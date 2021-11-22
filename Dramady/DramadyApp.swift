//
//  DramadyApp.swift
//  Dramady
//
//  Created by User on 22.11.2021.
//

import SwiftUI

@main
struct DramadyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
