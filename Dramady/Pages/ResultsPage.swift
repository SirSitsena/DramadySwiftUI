//
//  ResultsPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct ResultsPage: View {
    @Binding var searchText: String 
    @State var hasLoaded = false
    @State var movies = [MovieSearch]()
    var body: some View {
        List(movies) { movie in
            VStack(alignment: .leading) {
                Text("Title: " + movie.title)
                Text("Desc: " + movie.description)
            }
        }.task {
            Api().movieSearch(keyWords: searchText) { (movies) in
                self.movies = movies.results
            }
        }
        
//        if apiModel.isLoading == false {
//
//            VStack {
//                List {/*
//                    ForEach(apiModel.movieResult!.movies, id: \.self.id) {movie in
//                        HStack {
//                            Text("Title: " + movie.title)
//                            Text("Desc: " + movie.description)
//                        }
//                    }*/
//                }
//            }
//        } else {
//            //Validate search?
//            //let remote = try! apiModel.SearchMovie(keywords: searchText)
//            ProgressView()
//        }
    }
}

//struct ResultsPage_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultsPage()
//    }
//}
