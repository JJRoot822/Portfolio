//
//  GlucoTrackApp.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/26/24.
//

import SwiftUI

@main
struct GlucoTrackApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
