//
//  TrendingPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct TrendingPage: View {
    @State private var movies = [topMovie]()
    
    @State public var intStatus = false
    
    //func status(){
    //    monitor.pathUpdateHandler = { pathUpdateHandler in
    //               if pathUpdateHandler.status == .satisfied {
    //                   intStatus = true
    //                   print("Internet connection is on.")
    //               } else {
    //                   intStatus = false
    //                   print("There's no internet connection.")
    //               }
    //           }
    //           monitor.start(queue: queue)
    //}
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Trending Now")
                    .font(.title).bold().italic()
                    .foregroundColor(.yellow)

                List(movies) {movie in
                    NavigationLink(destination: MovieView(tId: movie.id)){
                        HStack{
                            AsyncImage(url: URL(string: movie.image)) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .frame(width: 50, height: 50, alignment: .leading)
                                } else if phase.error != nil {
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
                //intStatus = false
                //status()
                //if intStatus == true{
                    Api().fetchTop250 { (topMovies) in
                        self.movies = topMovies.items
                        //intStatus = false
                    }
                //} else {
                //    status()
                //}
                
            }
            }
        }.background(Color.black)
        .frame(minHeight: screenHeight)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

//struct TrendingPage_Previews: PreviewProvider {
//    static var previews: some View {
//        TrendingPage()
//    }
//}
