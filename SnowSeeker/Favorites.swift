//
//  Favorites.swift
//  SnowSeeker
//
//  Created by sovanmakara on 22/6/26.
//

import SwiftUI

@Observable
class Favorites {
    // the actual resorts the user has favorited
    private var resorts: Set<String>
    
    // the key we're using to read/write in UserDefaults
    private let key = "Favorites"
    
    init() {
        // load our saved data
        if let data = UserDefaults.standard.data(forKey: key){
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data){
                resorts = decoded
                return
            }
        }
        // still here? Use an empty array
        resorts = []
    }
    
    // return true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // at the resort to our set and saves the change
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    // remove the resort from our set and saves the change
    func remove(_ resort: Resort){
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
