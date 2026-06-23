//
//  ResortView.swift
//  SnowSeeker
//
//  Created by sovanmakara on 19/6/26.
//

import SwiftUI

struct ResortView: View {
    @State var viewModel: ResortViewModel
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    // load favorite set
    @Environment(Favorites.self) var favorites
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    Image(decorative: viewModel.resort.id)
                        .resizable()
                        .scaledToFit()
                    Text(viewModel.resort.imageCredit)
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
                        VStack(spacing: 10) { ResortDetailsView(resort: viewModel.resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: viewModel.resort) }
                    } else {
                        ResortDetailsView(resort: viewModel.resort)
                        SkiDetailsView(resort: viewModel.resort)
                    }
                }
                .padding(.vertical)
                .background(.regularMaterial)
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(viewModel.resort.description)
                        .lineSpacing(4)
                    
                    
                    // Facilities
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Facilities")
                            .font(.title3.bold())
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.resort.facilityType) { facility in
                                    Button {
                                        viewModel.selectFacility(facility)
                                    } label: {
                                        VStack(spacing: 8) {
                                            facility.icon.font(.title)
                                            Text(facility.name).font(.caption)
                                        }
                                        .frame(width: 90, height: 90)
                                        .background(.ultraThinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                    }
                                }
                            }
                        }
                    }
                    
                    Button {
                        viewModel.toggleFavorite(favorites: favorites)
                    } label: {
                        Label(
                            viewModel.isFavorite ? "Remove Favorite" : "Add to Favorites",
                            systemImage: viewModel.isFavorite ? "heart.fill" : "heart"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(viewModel.isFavorite ? .red : .blue)
                    .controlSize(.large)
                }
                .padding(20)
            }
        }
        .navigationTitle("\(viewModel.resort.name), \(viewModel.resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.updateFavoriteState(favorites: favorites) }
        .alert(
            viewModel.selectedFacility?.name ?? "More Information",
            isPresented: $viewModel.showingFacility,
            presenting: viewModel.selectedFacility) { _ in
            } message: { facility in
                Text(facility.description)
            }
    }
}

#Preview {
    ResortView(viewModel: ResortViewModel(resort: .example))
        .environment(Favorites())
}
