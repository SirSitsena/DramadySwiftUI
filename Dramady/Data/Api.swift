//
//  imdFile.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import Foundation
import Combine

struct SongSearch: Decodable {
    let lyrics: String
}


// Working version, completion handler. needs fixing for simultanous api calls?
class Api: ObservableObject {
    @Published var lyrics: String = ""
    let apiKey: String = "k_1dtwun41"
    
    // Unrelated function loading lyrics of song from artist and title
    func load(artist: String, title: String, completion: @escaping (SongSearch) -> ()) {
        let escapedArtist = artist.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let escapedTitle = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let stringUrl = "https://api.lyrics.ovh/v1/\(escapedArtist!)/\(escapedTitle!)"
        guard let url = URL(string: stringUrl) else {
            print("invalid url")
            return
        }
        URLSession.shared.dataTask(with: url) {data, response, error in
            let lyr = try! JSONDecoder().decode(SongSearch.self, from: data!)
            print(lyr)
            DispatchQueue.main.async {
                completion(lyr)
            }
        }.resume()
    }
    
    // Function for searching for a movie
    func movieSearch(keyWords: String, completion: @escaping (MoviesSearch) -> ()) {
        let escapedKeywords = keyWords.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let stringUrl = "https://imdb-api.com/en/API/SearchMovie/\(apiKey)/\(escapedKeywords!)"
        guard let url = URL(string: stringUrl) else {
            print("invalid url")
            return
        }
        URLSession.shared.dataTask(with: url) {data, response, error in
            let movies = try! JSONDecoder().decode(MoviesSearch.self, from: data!)
            print(movies)
            DispatchQueue.main.async {
                completion(movies)
            }
        }.resume()
    }
    //Fetch the top 250 movies on imdb
    func fetchTop250(completion: @escaping (topMovies) -> ()) {
        let stringUrl = "https://imdb-api.com/en/API/Top250Movies/\(apiKey)"
        guard let url = URL(string: stringUrl) else {
            print("invalid url")
            return
        }
        URLSession.shared.dataTask(with: url) {data, response, error in
            let movies = try! JSONDecoder().decode(topMovies.self, from: data!)
            print(movies)
            DispatchQueue.main.async {
                completion(movies)
            }
        }.resume()
    }
    //Fetch the most popular movies
    func fetchPopular(completion: @escaping (popularMovies) -> ()) {
        let stringUrl = "https://imdb-api.com/en/API/MostPopularMovies/\(apiKey)"
        guard let url = URL(string: stringUrl) else {
            print("invalid url")
            return
        }
        URLSession.shared.dataTask(with: url) {data, response, error in
            let movies = try! JSONDecoder().decode(popularMovies.self, from: data!)
            print(movies)
            DispatchQueue.main.async {
                completion(movies)
            }
        }.resume()
    }
}
