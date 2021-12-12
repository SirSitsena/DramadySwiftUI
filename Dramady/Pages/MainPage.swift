//
//  MainPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct MainPage: View {
    @State private var searchText = ""
    @ObservedObject var imagefetcher = ImageFetcher()
    
    
    var body: some View {
        VStack{
            NavigationView {

                        VStack {
                            Text("Searching for \(searchText)")
                                .foregroundColor(.yellow)
                                .searchable(text: $searchText)
                                .multilineTextAlignment(.leading)
                                .navigationTitle("Dramady Home")
                            NavigationLink(destination: ResultsPage(searchText: self.$searchText)) {
                                Text("Search!")
                            }
                                .padding(.top, 25)
                                .padding(.bottom, 95)
                        }
                
            }
            .padding(.top, 50)
            .frame(
                minHeight: 900,
                maxHeight: .infinity,
                alignment: .center
            )
    }.colorScheme(.dark)
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
}
