import SwiftUI

struct SchoolCard: View {
    let school: SchoolData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(school.namaSekolah)
                .font(.headline)
            Text(school.kodSekolah)
                .font(.subheadline)
                .foregroundColor(.blue)
            HStack {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.red)
                Text("\(school.negeri) - \(school.ppd)")
            }
            .font(.caption)
            .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.2), radius: 5)
    }
} 