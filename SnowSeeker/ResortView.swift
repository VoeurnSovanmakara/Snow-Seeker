//
//  ResortView.swift
//  SnowSeeker
//
//  Created by sovanmakara on 19/6/26.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    // load favorite set
    @Environment(Favorites.self) var favorites
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text(resort.imageCredit)
                        .font(.caption2)
                        .foregroundStyle(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.black.opacity(0.5))
                        .clipShape(.rect(cornerRadius: 4))
                        .padding(8)
                }
                
                HStack {
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort)}
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.regularMaterial)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(resort.facilityType) { facility in
                                Button {
                                    selectedFacility = facility
                                    showingFacility = true
                                } label: {
                                    VStack(spacing: 8) {
                                        facility.icon
                                            .font(.title)

                                        Text(facility.name)
                                            .font(.caption)
                                    }
                                    .frame(width: 90, height: 90)
                                    .background(.ultraThinMaterial)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 20)
                                    )
                                }
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                
                Button {
                    if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                } label: {
                    Label(
                        favorites.contains(resort)
                            ? "Remove Favorite"
                            : "Add to Favorites",
                        systemImage: favorites.contains(resort)
                            ? "heart.fill"
                            : "heart"
                    )
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            selectedFacility?.name ?? "More Information",
            isPresented: $showingFacility,
            presenting: selectedFacility) { _ in
            } message: { facility in
                Text(facility.description)
            }
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}
