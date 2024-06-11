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
//        .commands {
//            CommandGroup(replacing: .appSettings) {
//                EmptyView()
//            }
//            
//            CommandGroup(replacing: .systemServices) {
//                EmptyView()
//            }
//            
//            CommandGroup(replacing: .newItem) {
//                Button("Add New Author") { globalState.showingAddAuthor = true }
//                    .keyboardShortcut("N", modifiers: [ .command ])
//                
//            
//                Button("Add New Genre") { globalState.showingAddGenre = true }
//                    .keyboardShortcut("N", modifiers: [ .command, .option ])
//                
//                Button("Add New Book") { globalState.showingAddBook = true }
//                    .keyboardShortcut("N", modifiers: [ .command, .shift ])
//                
//                Button("Add New Book List") { globalState.showingAddBookList = true }
//                    .keyboardShortcut("N", modifiers: [ .command, .shift, .control, .option ])
//            }
//        }
    }
}
