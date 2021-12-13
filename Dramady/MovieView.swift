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
    @FetchRequest(entity:  LocalMovie.entity(), sortDescriptors: []) private var movies: FetchedResults<LocalMovie>
    
    
    @State var presentAlert: Bool = false
    @State var alertText: String = ""
    
    @State var localMovie: LocalMovie?
    @State var movie: FullMovie?
    //@State var localMovie: Movie?
    let tId: String
    
    func updateFavourite(movie: LocalMovie) {
        let newIsFavourited = movie.isFavourited ?  false : true
        print(newIsFavourited)
        viewContext.performAndWait {
            movie.isFavourited = newIsFavourited
            try? viewContext.save()
        }
    }
    
    func updateWatchlist(movie: LocalMovie) {
        let newIsOnWatchlist = movie.isOnWatchlist ? false : true
        print(newIsOnWatchlist)
        viewContext.performAndWait {
            movie.isOnWatchlist = newIsOnWatchlist
            try? viewContext.save()
        }
    }
    
    var body: some View {
        ScrollView{
            VStack {
                if let localMov = localMovie {
                    Text(localMov.title ?? "No title saved")
                        .font(.title)
                    if let imageStr = localMov.image {
                    AsyncImage(url: URL(string: imageStr)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } else if phase.error != nil {
                                ProgressView()
                            } else {
                                ProgressView()
                                //Color.blue
                            }
                        }
                    }
                    //.padding(.bottom, 15)
                    Text("Year: \(localMov.year ?? "")")
                        .padding(.bottom, 15)
                    Text("Imdb rating: \(localMov.imDbRating ?? "")")
                    .padding(.bottom, 15)
                    Text("Movie length: \(localMov.runtimeStr ?? "")")
                        .padding(.bottom, 15)
                    Text(localMov.plot ?? "no plot saved") //?? "No plot saved")
                    Button {
                        updateFavourite(movie: localMov)
                    } label: {
                        if localMov.isFavourited {
                            Text("Unfavourite")
                        } else {
                            Text("Favourite")
                        }
                    }
                    Button {
                        updateWatchlist(movie: localMov)
                    } label: {
                        if localMov.isOnWatchlist {
                            Text("Remove from watchlist")
                        } else {
                            Text("Add to watchlist")
                        }
                    }
                } else {
                    if let mov = movie {
                        Text(mov.title)
                            .font(.title)
                        AsyncImage(url: URL(string: mov.image)) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            } else if phase.error != nil {
                                ProgressView()
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
                        Button {
                            var alreadyOnlist = false
                            for aMovie in movies {
                                if aMovie.titleId == mov.id {
                                    alreadyOnlist = true
                                }
                            }
                            if alreadyOnlist {
                                self.alertText = "Movie already favourited"
                                self.presentAlert = true
                            }
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
                            print(newFavourite)
                            do {
                                try viewContext.save()
                            } catch {
                                print("error favouriting")
                            }
                            self.alertText = "Added to favourites"
                            self.presentAlert = true
                        } label: {
                            Text("Save to favourites")
                        }
                        Button {
                            var alreadyOnlist = false
                            for aMov in movies {
                                if aMov.titleId == mov.id {
                                    alreadyOnlist = true
                                }
                            }
                            if alreadyOnlist {
                                self.alertText = "Already on watchlist"
                                self.presentAlert = true
                            } else {
                                let newToWatch = LocalMovie(context: viewContext)
                                newToWatch.isFavourited = false
                                newToWatch.isOnWatchlist = true
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
                                self.alertText = "Added to watchlist"
                                self.presentAlert = true
                            }
                            
                        } label: {
                            Text("Add to watchlist")
                        }
                        Text(mov.plot)
                        
                    }
                }
                
                
            }.task {
                for localMov in movies {
                    if localMov.titleId == tId {
                        print(localMov)
                        print("Found")
                        self.localMovie = localMov
                    }
                }
                Api().fetchFromTitleID(titleId: tId, completion: { (fullMovie) in
                    self.movie = fullMovie
                })
            }
            .alert(isPresented: $presentAlert) {
                Alert(title: Text("Alert!"), message: Text(self.alertText), dismissButton: .default(Text("OK")))
            }.listStyle(InsetGroupedListStyle())
                .frame(minHeight: screenHeight)
//                .padding(.top, 50)
//                .padding(.bottom, 100)
        //}.frame(
        //    minHeight: 810,
        //    maxHeight: .infinity,
        //    alignment: .center
        //)

//        Text("---------")
//                .padding(.top,40)
        }
//        .padding(.top,0)
        
//        .navigationViewStyle(StackNavigationViewStyle())
            
}

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView()
//    }
//}
}
