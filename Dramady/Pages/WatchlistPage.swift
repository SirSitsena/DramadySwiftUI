//
//  WatchlistPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct WatchlistPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity:  LocalMovie.entity(), sortDescriptors: []) private var movies: FetchedResults<LocalMovie>
    
    init () {
        UITableView.appearance().backgroundColor = .black
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("My Watchlist")
                    .font(.title).bold().italic()
                    .foregroundColor(.yellow)
                Spacer()
                List(movies) { movie in
                    if movie.isOnWatchlist {
                        NavigationLink(destination: MovieView(tId: movie.titleId!)) {
                            VStack{
                                HStack{
                                    Text(movie.title!)
                                        .font(.title)
                                        .foregroundColor(.pink)
                                        .multilineTextAlignment(.center)
                                }.padding(.bottom, 5)
                                
                                HStack{
                                    Text("Genres: \(movie.genres!)")
                                        .padding(.leading, 0)
                                    Spacer()
                                    
                                }.padding(.bottom, 5)
                                
                                HStack{
                                    Text("Year: \(movie.year!)")
                                        .padding(.leading, 0)
                                    Text("Rating: \(movie.imDbRating!)")
                                        .padding(.leading, 20)
                                }.padding(.bottom, 5)
                                
                            }
                        }
                        }
                    }
                }
        }
        .background(Color.black)
        .frame(minHeight: screenHeight)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct WatchlistPage_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistPage()
    }
}
