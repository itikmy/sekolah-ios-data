import SwiftUI
import MapKit

struct SchoolDetailView: View {
    let school: SchoolData
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Maklumat Asas
                CardView(title: "Maklumat Asas", icon: "building.2.fill", color: .blue) {
                    InfoRow(title: "Nama", value: school.namaSekolah)
                    InfoRow(title: "Kod", value: school.kodSekolah)
                    InfoRow(title: "JPN", value: school.negeri)
                    InfoRow(title: "PPD", value: school.ppd)
                    InfoRow(title: "Jenis", value: school.jenisLabel)
                    InfoRow(title: "Peringkat", value: school.peringkat)
                }
                
                // Lokasi
                CardView(title: "Lokasi", icon: "mappin.circle.fill", color: .red) {
                    InfoRow(title: "Alamat", value: school.alamatSurat)
                    InfoRow(title: "Poskod", value: "\(school.poskodSurat)")
                    InfoRow(title: "Bandar", value: school.bandarSurat)
                    InfoRow(title: "Negeri", value: school.negeri)
                }
                
                // Hubungi
                CardView(title: "Hubungi", icon: "phone.circle.fill", color: .green) {
                    InfoRow(title: "Telefon", value: school.noTelefon)
                    InfoRow(title: "Fax", value: school.noFax)
                    InfoRow(title: "Email", value: school.email)
                }
                
                // Statistik
                CardView(title: "Statistik", icon: "chart.bar.fill", color: .purple) {
                    InfoRow(title: "Bantuan", value: school.bantuan)
                    InfoRow(title: "Murid", value: "\(school.murid)")
                    InfoRow(title: "Guru", value: "\(school.guru)")
                    InfoRow(title: "Prasekolah", value: school.prasekolah)
                    InfoRow(title: "Integrasi", value: school.integrasi)
                }
            }
            .padding()
        }
        .navigationTitle(school.namaSekolah)
        .navigationBarTitleDisplayMode(.inline)
    }
}
