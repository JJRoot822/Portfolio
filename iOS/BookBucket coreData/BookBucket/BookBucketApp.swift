//
//  BookBucketApp.swift
//  BookBucket
//
//  Created by Joshua Root on 2/20/24.
//

import SwiftUI
import SwiftData

@main
struct BookBucketApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                iPhoneApp()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            case .pad:
                iPadApp()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            default:
                EmptyView()
            }
        }
    }
}
