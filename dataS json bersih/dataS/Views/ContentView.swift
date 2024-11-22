//
//  ContentView.swift
//  dataS
//
//  Created by STDC_17 on 5/20/1446 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var schoolData: [SchoolData] = []
    @State private var searchText = ""
    
    var filteredSchools: [SchoolData] {
        if searchText.isEmpty {
            return schoolData
        }
        return schoolData.filter { school in
            school.namaSekolah.localizedCaseInsensitiveContains(searchText) ||
            school.kodSekolah.localizedCaseInsensitiveContains(searchText) ||
            school.negeri.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        NavigationView {
            List(filteredSchools) { school in
                NavigationLink(destination: SchoolDetailView(school: school)) {
                    VStack(alignment: .leading) {
                        Text(school.namaSekolah)
                            .font(.headline)
                        Text(school.kodSekolah)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Sekolah")
            .searchable(text: $searchText)
        }
        .onAppear {
            schoolData = SchoolDataManager.shared.loadJSON()
        }
    }
}
#Preview {
    ContentView()
}
