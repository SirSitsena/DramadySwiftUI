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
    
    @State public var intStatus = false
    
   // func status(){
   //     monitor.pathUpdateHandler = { pathUpdateHandler in
   //                if pathUpdateHandler.status == .satisfied {
   //                    self.intStatus = true
   //                    print("Internet connection is on.")
   //                } else {
   //                    self.intStatus = false
   //                    print("There's no internet connection.")
   //                }
   //            }
   //            monitor.start(queue: queue)
   // } ///
    
    
    var body: some View {
            NavigationView {
                VStack {
                    Text("Searching for \(searchText)")
                        .foregroundColor(.yellow)
                        .searchable(text: $searchText)
                        .multilineTextAlignment(.leading)
                        .navigationTitle(Text("Dramady"))
                    Button {
                        //status()
                        //Validate
                        if (self.searchText == "") {//||(self.intStatus == false) {
                            print(self.intStatus)
                            print(self.searchText)
                            self.alertText = """
                                            Please enter keywords before searching and internet connection
                                            """
                            self.presentAlert = true
                            self.searchActive = false
                            self.intStatus = false
                            //status()
                        } else {
                            //if intStatus == true{
                                self.searchActive = true
                                //status()
                            //}
                        }
                        
                    } label : {
                        Text("Search!")
                    }
                    NavigationLink(destination: ResultsPage(searchText: self.$searchText), isActive: $searchActive) { EmptyView()}
                    Spacer()
                    ScrollView {
                        Image("Icon-512").resizable()
                            .scaledToFit()
                        Text("Welcome to dramady!").font(.title)
                        Text("On this app you will have an easy way of storing your favourite movie's information, If  you would like you can save a movie to your favourites or simply add it to the watchlist. You can start off by trying to search for a movie of your choice in the bar above.")
                            .font(.body)
                        Divider()
                        Text("Thank you for using Dramady").font(.title3)
                    }
                }
                    .padding(.top, 25)
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
