//
//  PopularPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct PopularPage: View {
    @State private var movies = [popularMovie]()
    var body: some View {
        List(movies, id: \.id) {movie in
            VStack {
                Text(movie.title)
                Text(movie.fullTitle)
                Text(movie.rank)
            }
        }.task {
            Api().fetchPopular { (topmovies) in
                self.movies = topmovies.items
            }
        }
    }
}

struct PopularPage_Previews: PreviewProvider {
    static var previews: some View {
        PopularPage()
    }
}
