//
//  WatchlistPage.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

struct WatchlistPage: View {
    
    init () {
        UITableView.appearance().backgroundColor = .black
    }
    
    
    var body: some View {
            VStack{
                VStack{
                    Text("Hello World")
                }
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .center)
            .background(Color.red)
    }
}

struct WatchlistPage_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistPage()
    }
}
