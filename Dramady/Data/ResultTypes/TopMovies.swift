//
//  TopMovies.swift
//  Dramady
//
//  Created by User on 28.11.2021.
//

import Foundation

struct topMovies: Decodable {
    let items: [topMovie]
}
struct topMovie: Decodable, Identifiable {
    let id: String
    let rank: String
    let title: String
    let fullTitle: String
    let year: String
    let image: String
    let crew: String
    let imDbRating: String
    let imDbRatingCount: String
}
