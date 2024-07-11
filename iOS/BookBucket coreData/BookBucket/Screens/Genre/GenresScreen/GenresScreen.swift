//
//  GenresScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/25/24.
//

import SwiftUI
import SwiftData

struct GenresScreen: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            GenresList(sortCriteria: viewModel.sortCriteria, searchTerm: viewModel.searchTerm)
                .id(viewModel.id)
                .navigationTitle(Text("Genres"))
                .searchable(text: $viewModel.searchTerm, prompt: Text("Search for a Genre"))
                .sheet(isPresented: $viewModel.showingAddGenre) {
                    AddGenreScreen()
                }
                .toolbar {
                    GenreSortOrderPicker(selection: $viewModel.sortCriteria)
                    
                    Button(action: viewModel.showAddGenreScreen) {
                        Label("Add a new genre", systemImage: "plus")
                    }
                }
        }
    }
}
