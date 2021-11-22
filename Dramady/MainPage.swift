//
//  MainPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct MainPage: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
                
                
                VStack{
                    Text("Searching for \(searchText)")
                        .searchable(text: $searchText)
                        .navigationTitle("Search for movies")
//                    Text("Movies searched: 290")
//                    Text("Favourited movies: 290")
//                    Text("Movies in watched: 290")
                    Button("Let's do it!", action:{
                        searchText = ""
                    })
                }
            
    }
        
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
}
