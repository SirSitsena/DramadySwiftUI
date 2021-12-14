//
//  Configuration.swift
//  Dramady
//
//  Created by Rasmus Kolmodin on 2021-12-14.
//

import Foundation

class Configuration {
    
    func checkValidText(value: String?) -> String{
        if let val = value {
            if val != "" {
                return val
            }
        }
        return "N/A"
    }
    
    func tabIcon(name: String ) -> String {
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
    
    func inputEmptyCheckConf( searchText: String ) -> String {
                
        // Check empty string
        if searchText.isEmpty {
            return ""
        }
        // Trim and check empty string
        if (searchText.trimmingCharacters(in: .whitespaces) == ""){
            return searchText
        } else {
            return ""
        }
    }
}
