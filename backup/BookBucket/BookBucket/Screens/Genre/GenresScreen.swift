//
//  GenresScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/25/24.
//

import SwiftUI
import SwiftData

struct GenresScreen: View {
    @EnvironmentObject var globalState: GlobalState
    @State private var sortCriteria: GenreSortCriteria = .nameAscending
    @State private var searchTerm: String = ""
    @State private var id: UUID = UUID()
    
    var body: some View {
        NavigationStack {
            GenresList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                .id(id)
                .searchable(text: $searchTerm, prompt: Text("Search for an Author"))
                .refreshable(action: refresh)
                .sheet(isPresented: $globalState.showingAddGenre, onDismiss: {
                    id = id
                }) {
                    AddGenreScreen()
                }
                .toolbar {
                    GenreSortOrderPicker(selection: $sortCriteria)
                    
                    Button(action: showAddGenreScreen) {
                        Label("Add a new genre", systemImage: "plus")
                    }
                }
        }
    }
    
    private func showAddGenreScreen() {
        globalState.showingAddGenre = true
    }
    
    private func refresh() async {
        id = UUID()
    }
}
