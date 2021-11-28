//
//  Search.swift
//  Dramady
//
//  Created by User on 28.11.2021.
//

import Foundation

struct MoviesSearch: Decodable {
    let results: [MovieSearch]
}

struct MovieSearch: Decodable, Identifiable {
    let id: String
    let image: String
    let title: String
    let description: String
}
