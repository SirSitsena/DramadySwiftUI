//
//  ContentView.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//


//(Color.parseColor("#FFFFFF")

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    //@FetchRequest(
    //    sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
    //    animation: .default)
    //private var items: FetchedResults<Item>
    //@StateObject var apimodel = ApiModel()
    
    
    
    init() {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .systemYellow
    }
    

    var body: some View {
        
        TabView {
            MainPage()
                .tabItem {
                    Text("Main")
                    Image(systemName: "house")
                }
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
//        NavigationView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
//                    } label: {
//                        Text(item.timestamp!, formatter: itemFormatter)
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//}
//
//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
