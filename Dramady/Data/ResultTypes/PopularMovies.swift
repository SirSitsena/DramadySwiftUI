//
//  PopularMovies.swift
//  Dramady
//
//  Created by User on 28.11.2021.
//

import Foundation

struct popularMovies: Decodable {
    let items: [popularMovie]
}

struct popularMovie: Decodable {
    let id: String
    let rank: String
    let rankUpDown: String
    let title: String
    let fullTitle: String
    let year: String
    let image: String
    let crew: String
    let imDbRating: String
    let imDbRatingCount: String
}
