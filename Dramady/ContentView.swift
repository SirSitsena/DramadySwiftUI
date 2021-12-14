//
//  ContentView.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//


//(Color.parseColor("#FFFFFF")

import SwiftUI
import CoreData

import Network

//let monitor = NWPathMonitor()
//let queue = DispatchQueue(label: "InternetConnectionMonitor")


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let config = Configuration()
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .black
        
    }
    
    var body: some View {
        
            TabView {
                MainPage()
                    .tabItem {
                        Text("Main")
                        Image(systemName: config.tabIcon(name: "main"))
                    }
                    .colorScheme(.dark)
                TrendingPage()
                    .tabItem {
                        Text("Trending")
                        Image(systemName: config.tabIcon(name: "trending"))
                    }
                    .colorScheme(.dark)
                PopularPage()
                    .tabItem {
                        Text("Popular")
                        Image(systemName: config.tabIcon(name: "popular"))
                    }
                    .colorScheme(.dark)
                FavouritesPage()
                    .tabItem {
                        Text("Favourites")
                        Image(systemName: config.tabIcon(name:"favourites"))
                    }
                    .colorScheme(.dark)
                WatchlistPage()
                    .tabItem {
                        Text("Watchlist")
                        Image(systemName: config.tabIcon(name: "watchlist"))
                    }
                    .colorScheme(.dark)
            }
            .accentColor(.purple)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
