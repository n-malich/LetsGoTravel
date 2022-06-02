//
//  FavoriteManager.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import Foundation

class FavoriteManager {
    
    // MARK: - Properties
    static let shared = FavoriteManager()
    private var searchTokenFlights = [String]()
    
    // MARK: - Funcs
    func addToFavorites(token: String) {
        if searchTokenFlights.firstIndex(of: token) != nil {
            self.removeFromFavorites(token: token)
        } else {
            searchTokenFlights.append(token)
            print("Полёт добавлен в избранные")
        }
        print(searchTokenFlights)
    }
    
    private func removeFromFavorites(token: String) {
        if let index = searchTokenFlights.firstIndex(of: token) {
            searchTokenFlights.remove(at: index)
            print("Полёт удален из избранных")
            print(searchTokenFlights)
        }
    }
    
    func checkFlightStatus(token: String) -> Bool {
        if searchTokenFlights.firstIndex(of: token) != nil {
            return true
        } else {
            return false
        }
    }
}
