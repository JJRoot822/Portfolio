//
//  AuthorsListScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 3/8/24.
//

import SwiftUI

struct AuthorsListScreen: View {
    @State private var searchTerm: String = ""
    @State private var sortCriteria: AuthorSortCriteria = .nameAscending
    @State private var isShowingAddAuthorScreen: Bool = false
    
    var body: some View {
        NavigationStack {
            AuthorsList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                .searchable(text: $searchTerm, placement: .toolbar, prompt: Text("Search for an author"))
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        AuthorSortOrderPicker(selection: $sortCriteria)
                    }
                    
                    ToolbarItem(placement: .automatic) {
                        IconButton(title: "Add author", icon: "plus", action: showAddAuthorScreen)
                    }
                }
                .sheet(isPresented: $isShowingAddAuthorScreen, content: AddAuthorScreen.init)
                .navigationTitle(Text("Authors"))
                .navigationBarTitleDisplayMode(.large)
        }
    }
    
    private func showAddAuthorScreen() {
        self.isShowingAddAuthorScreen = true
    }
}
