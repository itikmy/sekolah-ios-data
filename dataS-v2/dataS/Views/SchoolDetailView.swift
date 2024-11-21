import SwiftUI
import MapKit

struct SchoolDetailView: View {
    let school: SchoolData
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Map
                Map {
                    Marker(school.namaSekolah, coordinate: CLLocationCoordinate2D(
                        latitude: school.koordinatY,
                        longitude: school.koordinatX
                    ))
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                // Info Cards
                CardView(title: "Maklumat Asas", icon: "building.2.fill", color: .blue) {
                    InfoRow(title: "Nama", value: school.namaSekolah)
                    InfoRow(title: "Kod", value: school.kodSekolah)
                    InfoRow(title: "Jenis", value: school.jenisLabel)
                    InfoRow(title: "Peringkat", value: school.peringkat)
                }
                
                CardView(title: "Lokasi", icon: "mappin.circle.fill", color: .red) {
                    InfoRow(title: "Negeri", value: school.negeri)
                    InfoRow(title: "PPD", value: school.ppd)
                    InfoRow(title: "Bandar", value: "\(school.bandarSurat), \(school.poskodSurat)")
                    InfoRow(title: "Alamat", value: school.alamatSurat)
                }
                
                CardView(title: "Hubungi", icon: "phone.circle.fill", color: .green) {
                    InfoRow(title: "Telefon", value: school.noTelefon)
                    InfoRow(title: "Fax", value: school.noFax)
                    InfoRow(title: "Email", value: school.email)
                }
                
                CardView(title: "Statistik", icon: "chart.bar.fill", color: .purple) {
                    InfoRow(title: "Murid", value: "\(school.murid)")
                    InfoRow(title: "Guru", value: "\(school.guru)")
                    InfoRow(title: "Prasekolah", value: school.prasekolah ? "Ya" : "Tidak")
                    InfoRow(title: "Integrasi", value: school.integrasi ? "Ya" : "Tidak")
                }
            }
            .padding()
        }
        .navigationTitle(school.namaSekolah)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color.gray.opacity(0.05))
    }
}
