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
                        .navigationTitle("Dramady Home")
                    NavigationLink(destination: ResultsPage(searchText: self.$searchText)) {
                        Text("Search!")
                    }
                }
                    .padding(.top, 25)
                    .padding(.bottom, 95)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .colorScheme(.dark)
//            .frame(
//            minHeight: screenHeight,
//            maxHeight: .infinity,
//            alignment: .center
//            )
}


}
struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
