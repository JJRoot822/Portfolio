//
//  MacApp.swift
//  BookBucket
//
//  Created by Joshua Root on 4/4/24.
//

import SwiftUI

struct MacApp: View {
    @EnvironmentObject var globalState: GlobalState
    
    var body: some View {
        NavigationSplitView(sidebar: {
            Sidebar()
        }, content: {
            Text("Nothing to Show Right Now")
                .font(.system(.title))
                .foregroundStyle(Color.secondary)
        }, detail: {
            Text("Nothing to Show Right Now")
                .font(.system(.title))
                .foregroundStyle(Color.secondary)
        })
        .toolbar {
            Menu(NSLocalizedString("Add", comment: ""), systemImage: "plus") {
                Button("Add New Book", action: showAddBookScreen)
                Button("Add New Book List", action: showAddBookListScreen)
                Button("Add New Author", action: showAddAuthorScreen)
                Button("Add New Genre", action: showAddGenreScreen)
            }
        }
    }
    
    private func showAddBookScreen() {
        self.globalState.showingAddBook = true
    }
    
    private func showAddBookListScreen() {
        globalState.showingAddBookList = true
    }
    
    private func showAddAuthorScreen() {
        globalState.showingAddAuthor = true
    }
    
    private func showAddGenreScreen() {
        globalState.showingAddGenre = true
    }
}
