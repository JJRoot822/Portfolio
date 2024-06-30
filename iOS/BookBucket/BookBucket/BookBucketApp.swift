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
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Author.self, Book.self, BookList.self, Genre.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                iPhoneApp()
            case .pad:
                iPadApp()
            default:
                EmptyView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
