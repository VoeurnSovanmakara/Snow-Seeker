//
//  ContentView.swift
//  SnowSeeker
//
//  Created by sovanmakara on 19/6/26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ContentViewModel()
    @State private var favorites = Favorites()

    
    var body: some View {
        NavigationSplitView {
            List(viewModel.filteredResorts) { resort in
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
                ResortView(viewModel: ResortViewModel(resort: resort))
            }
            .searchable(text: $viewModel.searchText, prompt: "Search for a resort")
            .toolbar {
                Menu {
                    Picker("Sort", selection: $viewModel.sortOrder) {
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
