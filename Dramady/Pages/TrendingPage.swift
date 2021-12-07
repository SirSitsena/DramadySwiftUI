//
//  TrendingPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct TrendingPage: View {
    @State private var movies = [popularMovie]()
    var body: some View {
        List(movies, id: \.id) {movie in
            VStack {
                Text(movie.title)
                Text(movie.fullTitle)
                Text(movie.rank)
                //TrendingMovieView()
            }
        }.task {
            Api().fetchPopular{ (popularmovies) in
                self.movies = popularmovies.items
            }
        }
    }
}

struct TrendingPage_Previews: PreviewProvider {
    static var previews: some View {
        TrendingPage()
    }
}
