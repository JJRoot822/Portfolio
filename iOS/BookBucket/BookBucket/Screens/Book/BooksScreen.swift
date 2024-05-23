//
//  BooksScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI
import SwiftData

struct BooksScreen: View {
    @EnvironmentObject var globalState: GlobalState
    
    @State private var sortCriteria: BookSortCriteria = .titleAscending
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationStack {
            BooksGrid(sortCriteria: sortCriteria, searchTerm: searchTerm)
                .navigationTitle(Text("Books"))
                .searchable(text: $searchTerm, prompt: Text("Search for a Book"))
                .sheet(isPresented: $globalState.showingAddBook) {
                    AddBookScreen()
                }
                .toolbar {
                    BookSortOrderPicker(selection: $sortCriteria)
                    
                    Button(action: showAddBookScreen) {
                        Label("Add a new Book", systemImage: "plus")
                    }
                }
        }
    }
    
    private func showAddBookScreen() {
        globalState.showingAddBook = true
    }
}
