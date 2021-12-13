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
        NavigationView {
            VStack{
                Text("Trending Now")
                    .font(.headline).bold().italic()
                    .foregroundColor(.yellow)

            List(movies) {movie in
                NavigationLink(destination: MovieView(tId: movie.id))
                {
                        HStack{
                            AsyncImage(url: URL(string: movie.image)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .leading)
                                } else if phase.error != nil {
//                                    Color.red
                                    ProgressView()
                                } else {
                                    ProgressView()
                                }
                            }
                            Text(movie.title)
                                .foregroundColor(.white)
                            Text(movie.rank)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                }
            }
            .padding(.top, 0)
            .listStyle(InsetGroupedListStyle())
            .colorScheme(.dark)
            .task {
                Api().fetchTop250 { (topMovies) in
                    self.movies = topMovies.items
                }
            }
            }
        }
        .frame(minHeight: screenHeight)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

//struct TrendingPage_Previews: PreviewProvider {
//    static var previews: some View {
//        TrendingPage()
//    }
//}
