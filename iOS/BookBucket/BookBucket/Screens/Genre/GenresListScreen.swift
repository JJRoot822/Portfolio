//
//  GenresListScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 3/10/24.
//

import SwiftUI

struct GenresListScreen: View {
    @State private var searchTerm: String = ""
    @State private var sortCriteria: GenreSortCriteria = .nameAscending
    @State private var isShowingAddGenreScreen: Bool = false
    
    var body: some View {
        NavigationStack {
            GenresList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                .searchable(text: $searchTerm, prompt: Text("Search for a Genre"))
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        GenreSortOrderPicker(selection: $sortCriteria)
                    }
                    
                    ToolbarItem(placement: .automatic) {
                        IconButton(title: "Add Genre", icon: "plus", action: showAddGenreScreen)
                    }
                }
                .sheet(isPresented: $isShowingAddGenreScreen, content: AddGenreScreen.init)
                .navigationTitle(Text("Genres"))
                .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func showAddGenreScreen() {
        self.isShowingAddGenreScreen = true
    }
}
