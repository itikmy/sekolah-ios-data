import Foundation

class SchoolDataManager {
    static let shared = SchoolDataManager()
    
    func loadJSON() -> [SchoolData] {
        guard let url = Bundle.main.url(forResource: "Data", withExtension: "json") else {
            print("❌ Tidak jumpa fail Data.json")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let schoolData = try decoder.decode([SchoolData].self, from: data)
            print("✅ Berjaya muat \(schoolData.count) sekolah")
            return schoolData
        } catch {
            print("❌ Error membaca JSON: \(error)")
            return []
        }
    }
} 
