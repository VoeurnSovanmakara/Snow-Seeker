//
//  ContentView.swift
//  SnowSeeker
//
//  Created by sovanmakara on 19/6/26.
//

import SwiftUI

enum SortOrder: String, CaseIterable {
    case `default` = "Default"
    case alphabetical = "Alphabetical"
    case country = "Country"
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sortOrder = SortOrder.default
    
    var filteredResorts: [Resort] {
        let sorted: [Resort]
        switch sortOrder {
        case .default:
            sorted = resorts
        case .alphabetical:
            sorted = resorts.sorted { $0.name < $1.name }
        case .country:
            sorted = resorts.sorted { $0.country < $1.country }
        }
        
        if searchText.isEmpty {
            return sorted
        } else {
            return sorted.filter { $0.name.localizedStandardContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack(spacing: 12) {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 32)
                            .clipShape(.rect(cornerRadius: 6))
                            .shadow(radius: 2)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs • \(resort.country)")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                                .imageScale(.small)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                Menu {
                    Picker("Sort", selection: $sortOrder) {
                        ForEach(SortOrder.allCases, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                } label: {
                    Label("Sort", systemImage: "line.3.horizontal.decrease")
                }
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
