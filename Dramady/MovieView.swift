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
    
    @State var setBlock: Bool = false
    
    
    @StateObject public var updView = updateView()
    
    @State var presentAlert: Bool = false
    @State var alertText: String = ""
    
    @State var localMovie: LocalMovie?
    @State var movie: FullMovie?

    let tId: String
    let config = Configuration()
    
    func updateFavourite(movie: LocalMovie) {
        let newIsFavourited = movie.isFavourited ?  false : true
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
                if let localMov = localMovie { //If the current movie is present in the CoreData check
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
                    Text("Year: \(config.checkValidText(value: localMov.year))")
                        .padding(.bottom, 15)
                    Text("Imdb rating: \(config.checkValidText(value: localMov.imDbRating))")
                    .padding(.bottom, 15)
                    Text("Movie length: \(config.checkValidText(value: localMov.runtimeStr))")
                        .padding(.bottom, 15)
                    Text(config.checkValidText(value: localMov.plot))
                    
                        Button {
                            updateFavourite(movie: localMov)
                            updView.status.toggle()
                            updView.objectWillChange.send()
                        } label: {
                            if localMov.isFavourited {
                                Text("Unfavourite")
                                    .foregroundColor(Color.purple)
                                    .font(.title).bold().italic()
                                    .padding(.top, 25)
                            } else {
                                Text("Favourite")
                                    .foregroundColor(Color.purple)
                                    .font(.title).bold()
                                    .padding(.top, 25)
                            }
                        }

                    
                        Button {
                            updateWatchlist(movie: localMov)
                            updView.status.toggle()
                            updView.objectWillChange.send()
                        } label: {
                            if localMov.isOnWatchlist {
                                Text("Remove from watchlist")
                                    .foregroundColor(Color.purple)
                                    .font(.title).bold().italic()
                                    .padding(.top, 25)
                                    .padding(.bottom, 30)
                            } else {
                                Text("To watchlist")
                                    .foregroundColor(Color.purple)
                                    .font(.title).bold()
                                    .padding(.top, 25)
                                    .padding(.bottom, 30)

                            }
                        }.padding(.bottom, 35)
                    Text("           ")
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
                            }
                        }
                        .padding(.bottom, 15)
                        Text("Year: \(config.checkValidText(value: mov.year))")
                            .padding(.bottom, 15)
                        Text("Imdb rating: \(config.checkValidText(value: mov.imDbRating))")
                        .padding(.bottom, 15)
                        Text("Movie length: \(config.checkValidText(value: mov.runtimeStr))")
                            .padding(.bottom, 15)

                        HStack{
                            Button {
                                if setBlock == false{
                                    setBlock = true
                                var alreadyOnlist = false
                                for aMovie in movies {
                                    if aMovie.titleId == mov.id {
                                        alreadyOnlist = true
                                    }
                                }
                                if alreadyOnlist {
                                    self.alertText = "Movie already favourited"
                                    self.presentAlert = true
                                    updView.status.toggle()
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
                            }
                            } label: {
                                Text("Favourite")
                                    .foregroundColor(Color.purple)
                            }.padding(.leading, 30)
                            Spacer()
                            Button {
                                if setBlock == false{
                                    setBlock = true
                                var alreadyOnlist = false
                                for aMov in movies {
                                    if aMov.titleId == mov.id {
                                        alreadyOnlist = true
                                    }
                                }
                                if alreadyOnlist {
                                    self.alertText = "Already on watchlist"
                                    self.presentAlert = true
                                    updView.status.toggle()//new
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
                            }
                            } label: {
                                Text("To watchlist")
                                    .foregroundColor(Color.purple)
                            }.padding(.trailing, 30)
                        }.padding(.bottom, 25)
                        Text(config.checkValidText(value: mov.plot))
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
            .listStyle(InsetGroupedListStyle())
            .alert(isPresented: $presentAlert) {
                Alert(title: Text("Alert!"), message: Text(self.alertText), dismissButton: .default(Text("OK")))
        }
}

//struct MovieView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieView()
//    }
//}
}
}
