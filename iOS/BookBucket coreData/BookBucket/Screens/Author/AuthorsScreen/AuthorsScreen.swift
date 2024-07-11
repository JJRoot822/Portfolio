//
//  AuthorsScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/24/24.
//

import SwiftUI

struct AuthorsScreen: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            AuthorsList(sortCriteria: viewModel.sortCriteria, searchTerm: viewModel.searchTerm)
                .id(viewModel.id)
                .navigationTitle(Text("Authors"))
                .searchable(text: $viewModel.searchTerm, prompt: Text("Search for an Author"))
                .sheet(isPresented: $viewModel.showingAddAuthor, onDismiss: viewModel.forceRefresh) {
                    AddAuthorScreen()
                }
                .toolbar {
                    AuthorSortOrderPicker(selection: $viewModel.sortCriteria)
                    
                    Button(action: viewModel.showAddAuthorScreen) {
                        Label("Add a new author", systemImage: "plus")
                    }
                }
        }
    }
}

