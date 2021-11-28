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
                        VStack {
                            Text("Searching for \(searchText)")
                                .searchable(text: $searchText)
                                .multilineTextAlignment(.leading)
                                .navigationTitle("Search for movies")
                            Button("Cinema time!", action:{
                                searchText = ""
                            })                                     //LOST THE CODE WHEN PULLED THE WRONG WAY
                                .padding(.top, 25)
                                .padding(.bottom, 95)
                            VStack{
                                HStack{
                                    Text("Movies searched: 290")
                                }
                                HStack{
                                    Text("Favourited movies: 290")
                                }
                                HStack{
                                    Text("Movies in watched: 290")
                                }
                            }
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                        }
            }
            .frame(
                maxHeight: .infinity
            )
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
}
