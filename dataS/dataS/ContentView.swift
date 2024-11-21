//
//  ContentView.swift
//  dataS
//
//  Created by STDC_17 on 5/20/1446 AH.
//

import SwiftUI
import MapKit

struct SchoolData: Identifiable {
    let id = UUID()
    let sekolah: String
    let negeri: String
    let ppd: String
    let peringkat: String
    let jenisLabel: String
    let kodSekolah: String
    let namaSekolah: String
    let alamatSurat: String
    let poskodSurat: String
    let bandarSurat: String
    let noTelefon: String
    let noFax: String
    let email: String
    let lokasi: String
    let bantuan: String
    let murid: Int
    let guru: Int
    let prasekolah: Bool
    let integrasi: Bool
    let koordinatX: Double
    let koordinatY: Double
}

struct ContentView: View {
    @State private var schoolData: [SchoolData] = []
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            
            VStack {
                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Cari sekolah...", text: $searchText)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
                .padding()
                
                // List of schools
                List(filteredSchools) { school in
                    NavigationLink(destination: SchoolDetailView(school: school)) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(school.namaSekolah)
                                .font(.headline)
                            Text(school.kodSekolah)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            HStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.red)
                                Text("\(school.negeri) - \(school.ppd)")
                            }
                            .font(.caption)
                            .foregroundColor(.gray)
                            
                            HStack {
                                Label("\(school.murid) murid", systemImage: "person.3")
                                Spacer()
                                Label("\(school.guru) guru", systemImage: "person.bust")
                            }
                            .font(.caption)
                            .foregroundColor(.blue)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Sekolah Malaysia")
        }
        .onAppear {
            loadCSV()
        }
    }
    
    var filteredSchools: [SchoolData] {
        if searchText.isEmpty {
            return schoolData
        }
        return schoolData.filter { school in
            school.namaSekolah.localizedCaseInsensitiveContains(searchText) ||
            school.kodSekolah.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private func loadCSV() {
        guard let path = Bundle.main.path(forResource: "Data", ofType: "csv") else {
            print("❌ Tidak jumpa fail Data.csv")
            return
        }
        
        do {
            let content = try String(contentsOfFile: path, encoding: .utf8)
            var rows = content.components(separatedBy: .newlines)
            
            // Buang baris kosong
            rows = rows.filter { !$0.isEmpty }
            
            // Skip header row
            let dataRows = rows.dropFirst()
            
            schoolData = dataRows.compactMap { row in
                let columns = row.components(separatedBy: ",")
                guard columns.count >= 21 else { return nil }
                
                return SchoolData(
                    sekolah: columns[0].trimmingCharacters(in: .whitespacesAndNewlines),
                    negeri: columns[1].trimmingCharacters(in: .whitespacesAndNewlines),
                    ppd: columns[2].trimmingCharacters(in: .whitespacesAndNewlines),
                    peringkat: columns[3].trimmingCharacters(in: .whitespacesAndNewlines),
                    jenisLabel: columns[4].trimmingCharacters(in: .whitespacesAndNewlines),
                    kodSekolah: columns[5].trimmingCharacters(in: .whitespacesAndNewlines),
                    namaSekolah: columns[6].trimmingCharacters(in: .whitespacesAndNewlines),
                    alamatSurat: columns[7].trimmingCharacters(in: .whitespacesAndNewlines),
                    poskodSurat: columns[8].trimmingCharacters(in: .whitespacesAndNewlines),
                    bandarSurat: columns[9].trimmingCharacters(in: .whitespacesAndNewlines),
                    noTelefon: columns[10].trimmingCharacters(in: .whitespacesAndNewlines),
                    noFax: columns[11].trimmingCharacters(in: .whitespacesAndNewlines),
                    email: columns[12].trimmingCharacters(in: .whitespacesAndNewlines),
                    lokasi: columns[13].trimmingCharacters(in: .whitespacesAndNewlines),
                    bantuan: columns[14].trimmingCharacters(in: .whitespacesAndNewlines),
                    murid: Int(columns[15].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0,
                    guru: Int(columns[16].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0,
                    prasekolah: columns[17].trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == "true",
                    integrasi: columns[18].trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == "true",
                    koordinatX: Double(columns[19].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0.0,
                    koordinatY: Double(columns[20].trimmingCharacters(in: .whitespacesAndNewlines)) ?? 0.0
                )
            }
            print("✅ Berjaya muat \(schoolData.count) sekolah")
        } catch {
            print("❌ Error membaca CSV: \(error)")
        }
    }
}

struct SchoolDetailView: View {
    let school: SchoolData
    @State private var mapRegion: MKCoordinateRegion
    
    init(school: SchoolData) {
        self.school = school
        // Tukar koordinat jika perlu (bergantung pada format dalam CSV anda)
        let coordinate = CLLocationCoordinate2D(
            latitude: school.koordinatY, // Tukar X dan Y jika perlu
            longitude: school.koordinatX
        )
        _mapRegion = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        ))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Peta
                Map {
                    Marker(school.namaSekolah, coordinate: CLLocationCoordinate2D(
                        latitude: school.koordinatY,
                        longitude: school.koordinatX
                    ))
                }
                .frame(height: 200)
                .cornerRadius(12)
                
                // Info Sections
                Group {
                    // Maklumat Asas
                    InfoCard(title: "Maklumat Asas") {
                        InfoRow(icon: "building.2", title: "Nama", value: school.namaSekolah)
                        InfoRow(icon: "number", title: "Kod", value: school.kodSekolah)
                        InfoRow(icon: "tag", title: "Jenis", value: school.jenisLabel)
                        InfoRow(icon: "stairs", title: "Peringkat", value: school.peringkat)
                    }
                    
                    // Lokasi
                    InfoCard(title: "Lokasi") {
                        InfoRow(icon: "map", title: "Negeri", value: school.negeri)
                        InfoRow(icon: "building.columns", title: "PPD", value: school.ppd)
                        InfoRow(icon: "location", title: "Alamat", value: school.alamatSurat)
                        InfoRow(icon: "location.circle", title: "Bandar", value: "\(school.bandarSurat), \(school.poskodSurat)")
                    }
                    
                    // Hubungi
                    InfoCard(title: "Hubungi") {
                        InfoRow(icon: "phone", title: "Telefon", value: school.noTelefon)
                        InfoRow(icon: "printer", title: "Fax", value: school.noFax)
                        InfoRow(icon: "envelope", title: "Email", value: school.email)
                    }
                    
                    // Statistik
                    InfoCard(title: "Statistik") {
                        InfoRow(icon: "person.3", title: "Murid", value: "\(school.murid)")
                        InfoRow(icon: "person.bust", title: "Guru", value: "\(school.guru)")
                        InfoRow(icon: "graduationcap", title: "Prasekolah", value: school.prasekolah ? "Ya" : "Tidak")
                        InfoRow(icon: "building.2.crop.circle", title: "Integrasi", value: school.integrasi ? "Ya" : "Tidak")
                    }
                }
            }
            .padding()
        }
        .navigationTitle(school.namaSekolah)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct InfoCard<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            content
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 24)
            Text(title)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
        }
        .font(.subheadline)
    }
}
#Preview {
    ContentView()
}
