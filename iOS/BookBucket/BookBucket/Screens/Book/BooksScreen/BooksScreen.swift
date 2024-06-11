//
//  BooksScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI

struct BooksScreen: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            BooksGrid(sortCriteria: viewModel.sortCriteria, searchTerm: viewModel.searchTerm)
                .navigationTitle(Text("Books"))
                .searchable(text: $viewModel.searchTerm, prompt: Text("Search for a Book"))
                .sheet(isPresented: $viewModel.isShowingAddBookScreen) {
                    AddBookScreen()
                }
                .toolbar {
                    BookSortOrderPicker(selection: $viewModel.sortCriteria)
                    
                    Button(action: viewModel.showAddBookScreen) {
                        Label("Add a new Book", systemImage: "plus")
                    }
                }
        }
    }
}
