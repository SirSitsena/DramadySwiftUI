//
//  PopularPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct PopularPage: View {
    @State private var movies = [popularMovie]()
    @ObservedObject var imageFetcher = ImageFetcher()
    @State var images: [String: UIImage] = [:]
    var body: some View {
        List(movies, id: \.id) {movie in
            VStack {
                HStack{
                    AsyncImage(url: URL(string: movie.image)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .frame(width: 50, height: 50, alignment: .leading)
                        } else if phase.error != nil {
                            Color.red
                        } else {
                            ProgressView()
                            //Color.blue
                        }
                    }
                    
                    Text(movie.title)
                    Text(movie.rank)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }.task {
            Api().fetchPopular { (popularMovies) in
                self.movies = popularMovies.items
            }
        }
    }
}


struct PopularPage_Previews: PreviewProvider {
    static var previews: some View {
        PopularPage()
    }
}
