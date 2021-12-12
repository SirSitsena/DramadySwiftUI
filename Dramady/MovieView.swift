//
//  MovieView.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI
import CoreData

struct MovieView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    let fetchRequest:NSFetchRequest<LocalMovie> = LocalMovie.fetchRequest()
    
    //@FetchRequest(entity: LocalMovie.entity(), sortDescriptors: []) var localMovies: FetchRequest<LocalMovie>

    //@FetchRequest(entity: Movie.entity(), sortDesciptors: []) var localMovies: FetchRequest<Movie>
    
    @State var movie: FullMovie?
    //@State var localMovie: Movie?
    let tId: String
    var body: some View {
        List{
            VStack {
                if let mov = movie {
                    Text(mov.title)
                        .font(.title)
                    AsyncImage(url: URL(string: mov.image)) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 200, height: 200, alignment: .leading)
                        } else if phase.error != nil {
                            Color.red
                        } else {
                            ProgressView()
                            //Color.blue
                        }
                    }
                    .padding(.bottom, 15)
                    Text("Year: \(mov.year)")
                        .padding(.bottom, 15)
                    Text("Imdb rating: \(mov.imDbRating)")
                    .padding(.bottom, 15)
                    Text("Movie length: \(mov.runtimeStr)")
                        .padding(.bottom, 15)
                    Text(mov.plot)
                    Button {
                        print(fetchRequest)
                        let newFavourite = LocalMovie(context: viewContext)
                        newFavourite.isFavourited = true
                        newFavourite.isOnWatchlist = false
                        newFavourite.imDbRating = mov.imDbRating
                        newFavourite.runtimeStr = mov.runtimeStr
                        newFavourite.fullTitle = mov.fullTitle
                        newFavourite.awards = mov.awards
                        newFavourite.genres = mov.genres
                        newFavourite.plot = mov.plot
                        newFavourite.keywords = mov.keywords
                        newFavourite.directors = mov.directors
                        newFavourite.year = mov.year
                        newFavourite.tagline = mov.tagline
                        newFavourite.title = mov.title
                        newFavourite.image = mov.image
                        newFavourite.titleId = mov.id
                        do {
                            try viewContext.save()
                        } catch {
                            print("error favouriting")
                        }
                    } label: {
                        Text("Save to favourites")
                    }
                    Button {
                        let newToWatch = LocalMovie(context: viewContext)
                        newToWatch.isFavourited = true
                        newToWatch.isOnWatchlist = false
                        newToWatch.imDbRating = mov.imDbRating
                        newToWatch.runtimeStr = mov.runtimeStr
                        newToWatch.fullTitle = mov.fullTitle
                        newToWatch.awards = mov.awards
                        newToWatch.genres = mov.genres
                        newToWatch.plot = mov.plot
                        newToWatch.keywords = mov.keywords
                        newToWatch.directors = mov.directors
                        newToWatch.year = mov.year
                        newToWatch.tagline = mov.tagline
                        newToWatch.title = mov.title
                        newToWatch.image = mov.image
                        newToWatch.titleId = mov.id
                        do {
                            try viewContext.save()
                        } catch {
                            print("error adding to toWatchlist")
                        }
                    } label: {
                        Text("Add to watchlist")
                    }
                }
            }.task {
                Api().fetchFromTitleID(titleId: tId, completion: { (fullMovie) in
                    self.movie = fullMovie
                })
            }
        }.frame(
            minHeight: 810,
            maxHeight: .infinity,
            alignment: .center
        )
        
    }
}

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView()
//    }
//}
