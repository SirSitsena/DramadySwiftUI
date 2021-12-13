//
//  PopularPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//
//(Color.parseColor("#7878AB")
//backgroundColor: 7878AB

import SwiftUI

struct PopularPage: View {
    @State private var movies = [popularMovie]()
    @ObservedObject var imageFetcher = ImageFetcher()
    @State var images: [String: UIImage] = [:]
    
//    init () {
//        UITableView.appearance().backgroundColor = .black
//    }
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Popular Movies")
                    .font(.headline).bold().italic()
                    .foregroundColor(.yellow)
            List(movies, id: \.id) {movie in
                NavigationLink(destination: MovieView(tId: movie.id)) {
                        HStack{
                            AsyncImage(url: URL(string: movie.image)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .leading)
                                } else if phase.error != nil {
                                    ProgressView()
//                                    Color.red
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
            .padding(.top, 0)
            .listStyle(InsetGroupedListStyle())
            .colorScheme(.dark)
            .task {
                Api().fetchPopular { (popularMovies) in
                    self.movies = popularMovies.items
                }
            }
                Spacer()
            }//.background(Color.red)
        }
        .background(Color.black)
        .frame(minHeight: screenHeight)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}


struct PopularPage_Previews: PreviewProvider {
    static var previews: some View {
        PopularPage()
    }
}
