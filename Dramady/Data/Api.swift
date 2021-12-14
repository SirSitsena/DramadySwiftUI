//
//  imdFile.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//
/*
 Unlimited(5000 calls) key:------- k_9t0l0iej ---------
 Rasmus Key: k_1dtwun41  ---- New Api Calls: 13/12/2021
 Anestis2 key: k_rs8s2dp4 ---- New Api Calls: 13/12/2021
 Anestis3 key: k_v58ritkw ---- New Api Calls: 13/12/2021
 Anestis4 key: k_suvzqf76 ---- New Api Calls: Active
 */


import Foundation
import Combine

struct SongSearch: Decodable {
    let lyrics: String
}


// Working version, completion handler. needs fixing for simultanous api calls?
class Api: ObservableObject {
    @Published var lyrics: String = ""
    let apiKey: String = "k_9t0l0iej"
    
    // FRANKENSTEIN - Unrelated function loading lyrics of song from artist and title
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
            //print(lyr)
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
            guard let data = data else {
                print("No data found")
                return
            }
            
            guard let movies = try? JSONDecoder().decode(MoviesSearch.self, from: data) else {
                print("Couldn't  decode data")
                return
            }
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
            guard let data = data else {
                print("No data")
                return
            }
            guard let movies = try? JSONDecoder().decode(topMovies.self, from: data) else {
                print("Could't decode data")
                return
            }
            //print(movies)
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
            guard let data = data else {
                print("No data")
                return
            }
            
            guard let movies = try? JSONDecoder().decode(popularMovies.self, from: data) else {
                print("Couldn't decode data")
                return
            }
            DispatchQueue.main.async {
                completion(movies)
            }
        }.resume()
    }
    
    //Fetch a full movie, this is the  format that the movie is saved on  the device with.
    func fetchFromTitleID(titleId: String, completion: @escaping (FullMovie) -> ()) {
        let stringUrl = "https://imdb-api.com/en/API/Title/\(apiKey)/\(titleId)"
        guard let url = URL(string: stringUrl) else {
            print("invalid URL") //HANDLE
            return
        }
        URLSession.shared.dataTask(with: url) {data,  response, error  in
            guard let data = data else {
                print("Data nil")
                return
            }
            guard let results = try? JSONDecoder().decode(FullMovie.self, from: data) else {
                print("Couldn't decode data")
                return
            }
            DispatchQueue.main.async {
                completion(results)
            }
        }.resume()
    }
}
