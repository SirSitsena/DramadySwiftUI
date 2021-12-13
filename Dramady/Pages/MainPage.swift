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
    @State private var searchActive: Bool = false
    @State private var presentAlert: Bool = false
    @State private var alertText: String = ""
    
    
    var body: some View {
            NavigationView {
                VStack {
                    
                    Text("Searching for \(searchText)")
                        .foregroundColor(.yellow)
                        .searchable(text: $searchText)
                        .multilineTextAlignment(.leading)
                        .navigationTitle(Text("Dramady"))
                    Button {
                        //Validate
                        if self.searchText == "" {
                            self.alertText = "Please enter keywords before searching"
                            self.presentAlert = true
                        } else {
                            self.searchActive = true
                        }
                        
                    } label : {
                        Text("Search!")
                    }
                    
                    NavigationLink(destination: ResultsPage(searchText: self.$searchText), isActive: $searchActive) { EmptyView()}
                    Spacer()
                }
                    .padding(.top, 25)
                    //.padding(.bottom, 95)
            }
            .background(Color.black)
            .navigationViewStyle(StackNavigationViewStyle())
            .colorScheme(.dark)
        
            .alert(isPresented: $presentAlert) {
                Alert(title: Text("Alert!"), message: Text(self.alertText), dismissButton: .default(Text("OK")))
            }
    }
}
struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
