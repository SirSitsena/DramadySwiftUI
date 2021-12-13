//
//  FavouritesPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct FavouritesPage: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity:  LocalMovie.entity(), sortDescriptors: []) private var movies: FetchedResults<LocalMovie>
    
    init () {
        UITableView.appearance().backgroundColor = .black
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("My Favourites")
                    .font(.headline).bold().italic()
                    .foregroundColor(.yellow)
                Spacer()
                List(movies) { movie in
                    if movie.isFavourited, movie.titleId != nil {
                        NavigationLink(destination: MovieView(tId: movie.titleId!)) {
                            HStack {
                                Text(movie.title  ?? "Nothing here")
                                //Text(movie.id) //?? "No id")
                                Text(movie.imDbRating ??  "No rating")
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

struct FavouritesPage_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesPage()
    }
}
