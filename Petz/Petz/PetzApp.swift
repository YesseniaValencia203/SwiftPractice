//
//  PetzApp.swift
//  Petz
//
//  Created by Consultant on 4/6/22.
//

import SwiftUI

@main
struct PetzApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
