//
//  Configuration.swift
//  Dramady
//
//  Created by Rasmus Kolmodin on 2021-12-14.
//

import Foundation

class Configuration {
    
    func checkValidText( value: String? ) -> String {
        if let val = value {
            if val != "" {
                return val
            }
        }
        return "N/A"
    }
    
    func tabIcon( name: String ) -> String {
        let low = name.lowercased()
        switch low {
        case "main":
            return "house"
        case "trending":
            return "arrow.uturn.up"
        case "popular":
            return "star"
        case "favourites":
            return "heart"
        case "watchlist":
            return "clock.fill"
        default:
            return ""
        }
    }
    
    func inputEmptyCheck( searchText: String ) -> Bool {
                
        // Check empty string
        if ( searchText.isEmpty ) || ( searchText.trimmingCharacters( in: .whitespaces ) == "" ) {
            return true
        } else {
            return false
        }
    }
    
    func watchListStatus( isOnWatchList: Bool ) -> String {
        if isOnWatchList{
            return "clock.fill"
        } else {
            return "clock"
        }
    }
    
    func favListStatus( isOnFavList: Bool ) -> String {
        if isOnFavList{
            return "heart.fill"
        } else {
            return "heart"
        }
    }
    
}
