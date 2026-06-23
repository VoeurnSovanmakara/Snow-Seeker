//
//  ContentViewModel.swift
//  SnowSeeker
//
//  Created by sovanmakara on 23/6/26.
//

import Foundation

enum SortOrder: String, CaseIterable {
    case `default` = "Default"
    case alphabetical = "Alphabetical"
    case country = "Country"
}

@Observable
class ContentViewModel {
    var resorts: [Resort] = Bundle.main.decode("resorts.json")
    var searchText = ""
    var sortOrder = SortOrder.default
    
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
}
