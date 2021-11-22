//
//  imdFile.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import Foundation
import Combine

struct MovieSearch: Decodable {
    let id: String
    let image: String
    let title: String
    let description: String
}

class ApiModel: ObservableObject {
    //@Published var isLoading = false
    let apiKey: String = "k_1dtwun41" //Rasmus key plz dont steal xd
    //var remote: Remote // How to initiate remote without declaring the generic type, it needs to be redeclared later on, and still needs to know if isLoading..
    private var cancellableTask: AnyCancellable?
    
    
    //Fetching a single movie // RASMUS
    func SearchMovie(keywords: String) {
        //TODO
        // url : https://imdb-api.com/en/API/SearchMovie/k_1dtwun41/inception%202010
        let escapedKeywords = keywords.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let stringUrl = "https://imdb-api.com/en/API/SearchMovie/\(apiKey)/\(escapedKeywords)"
        if let url = URL(string: stringUrl) {
            let remote = Remote<MovieSearch>(url: url)
        }
    }
}
