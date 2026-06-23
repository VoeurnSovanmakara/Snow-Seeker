//
//  ResortViewModel.swift
//  SnowSeeker
//
//  Created by sovanmakara on 23/6/26.
//

import Foundation

@Observable
class ResortViewModel {
    let resort: Resort
    var selectedFacility: Facility?
    var showingFacility = false
    var isFavorite = false
    
    init(resort: Resort) {
        self.resort = resort
    }
    
    func updateFavoriteState(favorites: Favorites) {
        isFavorite = favorites.contains(resort)
    }
    
    func toggleFavorite(favorites: Favorites) {
        if favorites.contains(resort) {
            favorites.remove(resort)
        } else {
            favorites.add(resort)
        }
        isFavorite = favorites.contains(resort)
    }
    
    func selectFacility(_ facility: Facility) {
        selectedFacility = facility
        showingFacility = true
    }
    
    var sizeLabel: String {
            switch resort.size {
            case 1: "Small"
            case 2: "Average"
            default: "Large"
            }
        }

    var priceLabel: String {
        String(repeating: "$", count: resort.price)
    }
}
