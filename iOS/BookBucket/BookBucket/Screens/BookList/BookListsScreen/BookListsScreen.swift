//
//  BookListsScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/30/24.
//

import SwiftUI
import SwiftData

struct BookListsScreen: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            BookListsList(sortCriteria: viewModel.sortCriteria, searchTerm: viewModel.searchTerm)
                .navigationTitle(Text("BookLists"))
                .searchable(text: $viewModel.searchTerm, prompt: Text("Search for a Book List"))
                .sheet(isPresented: $viewModel.showingAddBookList, onDismiss: {
                    viewModel.id = UUID()
                }) {
                    AddBookListScreen()
                }
                .toolbar {
                    BookListsSortOrderPicker(selection: $viewModel.sortCriteria)
                    
                    Button(action: viewModel.showAddBookListScreen) {
                        Label("Add a new book list", systemImage: "plus")
                    }
                }
        }
    }
    
}
