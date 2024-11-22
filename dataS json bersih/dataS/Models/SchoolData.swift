import Foundation

struct SchoolData: Identifiable, Codable {
    let id = UUID()
    let negeri: String
    let ppd: String
    let peringkat: String
    let jenisLabel: String
    let kodSekolah: String
    let namaSekolah: String
    let alamatSurat: String
    let poskodSurat: Int
    let bandarSurat: String
    let noTelefon: String
    let noFax: String
    let email: String
    let lokasi: String
    let bantuan: String
    let murid: Int
    let guru: Int
    let prasekolah: String
    let integrasi: String
    let koordinatX: Double
    let koordinatY: Double
    
    enum CodingKeys: String, CodingKey {
        case negeri = "NEGERI"
        case ppd = "PPD"
        case peringkat = "PERINGKAT"
        case jenisLabel = "JENIS/LABEL"
        case kodSekolah = "KODSEKOLAH"
        case namaSekolah = "NAMASEKOLAH"
        case alamatSurat = "ALAMATSURAT"
        case poskodSurat = "POSKODSURAT"
        case bandarSurat = "BANDARSURAT"
        case noTelefon = "NOTELEFON"
        case noFax = "NOFAX"
        case email = "EMAIL"
        case lokasi = "LOKASI"
        case bantuan = "BANTUAN"
        case murid = "MURID"
        case guru = "GURU"
        case prasekolah = "PRASEKOLAH"
        case integrasi = "INTEGRASI"
        case koordinatX = "KOORDINATXX"
        case koordinatY = "KOORDINATYY"
    }
}
