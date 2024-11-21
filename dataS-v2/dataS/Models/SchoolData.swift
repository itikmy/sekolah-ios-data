import Foundation

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