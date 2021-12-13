//
//  MainPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

let screenSize = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

struct MainPage: View {
    @State private var searchText = ""
    @ObservedObject var imagefetcher = ImageFetcher()
    var body: some View {
            NavigationView {
                VStack {
                    Text("Searching for \(searchText)")
                        .foregroundColor(.yellow)
                        .searchable(text: $searchText)
                        .multilineTextAlignment(.leading)
                        .navigationTitle(Text("New movie search"))
                    NavigationLink(destination: ResultsPage(searchText: self.$searchText)) {
                        Text("Search!")
                    }
//                    Spacer()
                }
                    .padding(.top, 25)
            }.background(Color.black)
            .navigationViewStyle(StackNavigationViewStyle())
            .colorScheme(.dark)
    }
}
struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
