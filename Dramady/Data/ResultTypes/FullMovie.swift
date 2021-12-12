//
//  FullMovie.swift
//  Dramady
//
//  Created by Rasmus Kolmodin on 2021-12-11.
//

import Foundation

struct FullMovie: Decodable {
    let id: String
    let title: String
    let fullTitle: String
    let year: String
    let image: String
    let releaseDate: String
    let runtimeMins: String
    let runtimeStr: String
    let plot: String
    let awards: String
    let directors: String
    let stars: String
    let genres: String
    let imDbRating: String
    let keywords: String
    let tagline: String
}
