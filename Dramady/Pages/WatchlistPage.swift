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
            VStack{
                List(movies) { movie in
                    if movie.isOnWatchlist {
                        VStack {
                            Text(movie.title  ?? "Nothing here")
                            //Text(movie.id) //?? "No id")
                            Text(movie.image ??  "No image")
                        }
                    }
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center)
            .background(Color.red)
    }
}

struct WatchlistPage_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistPage()
    }
}
