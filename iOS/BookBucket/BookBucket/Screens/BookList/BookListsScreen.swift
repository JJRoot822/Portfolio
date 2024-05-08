//
//  BookListsScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/30/24.
//

import SwiftUI
import SwiftData

struct BookListsScreen: View {
    @EnvironmentObject var globalState: GlobalState
    @State private var sortCriteria: BookListSortCriteria = .nameAscending
    @State private var searchTerm: String = ""
    @State private var id: UUID = UUID()
    
    var body: some View {
        NavigationStack {
            BookListsList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                .navigationTitle(Text("BookLists"))
                .searchable(text: $searchTerm, prompt: Text("Search for a Book List"))
                .sheet(isPresented: $globalState.showingAddBookList, onDismiss: {
                    id = id
                }) {
                    AddBookListScreen()
                }
                .toolbar {
                    BookListsSortOrderPicker(selection: $sortCriteria)
                    
                    Button(action: showAddBookListScreen) {
                        Label("Add a new book list", systemImage: "plus")
                    }
                }
        }
    }
    
    private func showAddBookListScreen() {
        globalState.showingAddBookList = true
    }
    
}
