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
    
    func status(){
        monitor.pathUpdateHandler = { pathUpdateHandler in
                   if pathUpdateHandler.status == .satisfied {
                       intStatus = true
                       print("Internet connection is on.")
                   } else {
                       intStatus = false
                       print("There's no internet connection.")
                   }
               }
               monitor.start(queue: queue)
    }
    
    
    var body: some View {
            NavigationView {
                VStack {
                    
                    Text("Searching for \(searchText)")
                        .foregroundColor(.yellow)
                        .searchable(text: $searchText)
                        .multilineTextAlignment(.leading)
                        .navigationTitle(Text("Dramady"))
                    Button {
                        status()
//                        if intStatus == false{
//                            self.alertText = "No internet connection"
//                            self.presentAlert = true
//                            self.searchActive = false
//                        } else {
//                            if intStatus == true{
//                                self.searchActive = true
//                            }
//                        }
//                        //Validate
                        if (self.searchText == "")||(intStatus == false) {
                            self.alertText = """
                                            Please enter keywords before searching and internet connection
                                            """
                            self.presentAlert = true
                            self.searchActive = false
                            intStatus = false
                            status()
                        } else {
                            if intStatus == true{
                                self.searchActive = true
                                status()
                            }
                            
                        }
                        
                    } label : {
                        Text("Search!")
                    }
                    
                    NavigationLink(destination: ResultsPage(searchText: self.$searchText), isActive: $searchActive) { EmptyView()}
//                    Spacer()
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
