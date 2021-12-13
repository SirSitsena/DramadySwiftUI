//
//  ResultsPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct ResultsPage: View {
    @Binding var searchText: String 
    @State var movies = [MovieSearch]()
    var body: some View {
        VStack{
            List(movies) { movie in
                NavigationLink(destination: MovieView(tId: movie.id)) {
                        VStack(alignment: .leading) {
                            Text("Title: " + movie.title)
                            Text("Year: " + movie.description)
                        }
                    }
            }.task {
                Api().movieSearch(keyWords: searchText) { (movies) in
                    self.movies = movies.results
                }
            }
        }
        .background(Color.black)
        .frame(
            minHeight: 900,
            maxHeight: .infinity,
            alignment: .center
        )
        
    }
}

//struct ResultsPage_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultsPage()
//    }
//}
