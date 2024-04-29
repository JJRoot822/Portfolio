//
//  AuthorsScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/24/24.
//

import SwiftUI
import SwiftData

struct AuthorsScreen: View {
    @EnvironmentObject var globalState: GlobalState
    @State private var sortCriteria: AuthorSortCriteria = .nameAscending
    @State private var searchTerm: String = ""
    @State private var id: UUID = UUID()
    
    var body: some View {
        NavigationStack {
            AuthorsList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                .id(id)
                .navigationTitle(Text("Authors"))
                .searchable(text: $searchTerm, prompt: Text("Search for an Author"))
                .refreshable(action: refresh)
                .sheet(isPresented: $globalState.showingAddAuthor, onDismiss: {
                    id = id
                }) {
                    AddAuthorScreen()
                }
                .toolbar {
                    AuthorSortOrderPicker(selection: $sortCriteria)
                    
                    Button(action: showAddAuthorScreen) {
                        Label("Add a new author", systemImage: "plus")
                    }
                }
        }
    }
    
    private func showAddAuthorScreen() {
        globalState.showingAddAuthor = true
    }
    
    private func refresh() async {
        id = UUID()
    }
}
