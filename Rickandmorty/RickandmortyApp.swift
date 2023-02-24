//
//  RickandmortyApp.swift
//  Rickandmorty
//
//  Created by jorgemht on 24/2/23.
//

import SwiftUI

@main
struct RickandmortyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
