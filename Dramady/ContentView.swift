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

let monitor = NWPathMonitor()
let queue = DispatchQueue(label: "InternetConnectionMonitor")


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    //@FetchRequest(
    //    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //    animation: .default)
    //private var items: FetchedResults<Item>
    //@StateObject var apimodel = ApiModel()
    
    
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .black    }

    
    var body: some View {
        
            TabView {
                MainPage()
                    .tabItem {
                        Text("Main")
                        Image(systemName: "house")
                    }
                    .colorScheme(.dark)
                TrendingPage()
                    .tabItem {
                        Text("Trending")
                        Image(systemName: "arrow.uturn.up")
                    }
                    .colorScheme(.dark)
                PopularPage()
                    .tabItem {
                        Text("Popular")
                        Image(systemName: "star")
                    }
                    .colorScheme(.dark)
                FavouritesPage()
                    .tabItem {
                        Text("Favourites")
                        Image(systemName: "heart")
                    }
                    .colorScheme(.dark)
                WatchlistPage()
                    .tabItem {
                        Text("Watchlist")
                        Image(systemName: "clock.fill")
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
