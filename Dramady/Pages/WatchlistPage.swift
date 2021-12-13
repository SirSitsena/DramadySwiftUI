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
                    .font(.headline).bold().italic()
                    .foregroundColor(.yellow)
                Spacer()
                List(movies) { movie in
                    if movie.isOnWatchlist {
                        NavigationLink(destination: MovieView(tId: movie.titleId!)) {
                            VStack {
                                Text(movie.title  ?? "Nothing here")
                                //Text(movie.id) //?? "No id")
                                Text(movie.image ??  "No image")
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
