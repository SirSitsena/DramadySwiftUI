//
//  Configuration.swift
//  Dramady
//
//  Created by Rasmus Kolmodin on 2021-12-14.
//

import Foundation

class Configuration {
    
    
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
}
