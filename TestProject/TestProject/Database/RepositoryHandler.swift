//
//  RepositoryHandler.swift
//  TestProject
//
//  Created by Pavan Kumar Valluru on 21.03.20.
//  Copyright © 2020 Pavan Kumar Valluru. All rights reserved.
//

import Foundation

protocol PersistanceAccessible {
    var persistanceHandler: RepositoryHandler { get }
}

extension PersistanceAccessible {
    var persistanceHandler: RepositoryHandler {
        return RepositoryHandler.shared
    }
}

class RepositoryHandler {

    fileprivate static let shared = RepositoryHandler()

    private init() { }

    func getExistingBookmarkListings() -> [Listing] {
        if let data = UserDefaults.standard.object(forKey: GlobalConstants.FavoritesKey) as? Data,
            let favorites = try? JSONDecoder().decode([Listing].self, from: data) {
            return favorites
        }
        return []
    }

    func setBookmark(for listing: Listing, to state: Bool) {
        var favorites = getExistingBookmarkListings()
        if state {
            favorites.append(listing)
        } else {
            favorites = favorites.filter { $0 != listing}
        }
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favorites)
            UserDefaults.standard.set(data, forKey: GlobalConstants.FavoritesKey)
        } catch {
            Log.error("Can't encode data: \(error)")
        }
    }

    func isBookmarkExists(for listing: Listing) -> Bool {
        return RepositoryHandler.shared.getExistingBookmarkListings().contains(listing)
    }

    func removeAllBookmarks() {
        do {
            let array: [Listing] = []
            let encoder = JSONEncoder()
            let data = try encoder.encode(array)
            UserDefaults.standard.set(data, forKey: GlobalConstants.FavoritesKey)
        } catch {
            Log.error("Can't encode data: \(error)")
        }
    }

}
