import Foundation

class SchoolDataManager {
    static let shared = SchoolDataManager()
    
    func loadCSV() -> [SchoolData] {
        var schoolData: [SchoolData] = []
        
        guard let path = Bundle.main.path(forResource: "Data", ofType: "csv") else {
            print("❌ Tidak jumpa fail Data.csv")
            return []
        }
        
        do {
            let content = try String(contentsOfFile: path, encoding: .utf8)
            var rows = content.components(separatedBy: .newlines)
            rows = rows.filter { !$0.isEmpty }
            let dataRows = rows.dropFirst()
            
            for row in dataRows {
                let columns = row.components(separatedBy: ",")
                print("Row: \(row)") // Debugging
                print("Columns: \(columns)") // Debugging
                
                guard columns.count >= 21 else {
                    print("❌ Baris tidak lengkap: \(row)")
                    continue // Skip this row
                }
                
                let school = SchoolData(
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
                schoolData.append(school)
            }
            
            print("✅ Berjaya muat \(schoolData.count) sekolah")
            return schoolData
        } catch {
            print("❌ Error membaca CSV: \(error)")
            return []
        }
    }
} 
