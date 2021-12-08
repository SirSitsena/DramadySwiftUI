//
//  TrendingPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct TrendingPage: View {
    @State private var movies = [topMovie]()
    @ObservedObject var imageFetcher = ImageFetcher()
    @State var images: [String: UIImage] = [:]
    
//    @State var image = UIImage()
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
                    
                    
                    
                    //REAL MAN FIX MOVE UNWRAPPING THE
//                    Image(uiImage: images[movie.id]!)
//                        .resizable()
//                        .frame(width: 50, height: 50, alignment: .leading)
//                        .onReceive(imageFetcher.$image, perform: { image in
//                            self.images[movie.id] = image
//                        })
//                        .onAppear(perform: {
//                            images[movie.id] = UIImage()
//                            imageFetcher.loadImage(for: movie.image)
//                        })
                    Text(movie.title)
                    Text(movie.rank)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                //TrendingMovieView()
            }
        }.task {
            Api().fetchTop250 { (topMovies) in
                self.movies = topMovies.items
            }
        }
    }
}

//struct TrendingPage_Previews: PreviewProvider {
//    static var previews: some View {
//        TrendingPage()
//    }
//}
