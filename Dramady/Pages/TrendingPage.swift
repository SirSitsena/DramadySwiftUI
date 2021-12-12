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
    
//    init () {
//        UITableView.appearance().backgroundColor = .purple
//    }
    
//    @State var image = UIImage()
    var body: some View {
        
        VStack{
            Text("Trending Now")
                .foregroundColor(.yellow)
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
                        .foregroundColor(.white)
                    Text(movie.rank)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .colorScheme(.dark)
        .task {
            Api().fetchTop250 { (topMovies) in
                self.movies = topMovies.items
        }
        }
        }
        .background(Color.green)
    }
}

//struct TrendingPage_Previews: PreviewProvider {
//    static var previews: some View {
//        TrendingPage()
//    }
//}
