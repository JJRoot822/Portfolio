//
//  FavoritesScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/28/24.
//

import SwiftUI
import SwiftData

struct FavoritesScreen: View {
    @State private var sortCriteria: FavoritesSortCriteria = .nameAscending
    @State private var selectedCategory: Category = .authors
    @State private var searchTerm: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                FavoritesCategoryPicker(selection: $selectedCategory)
                
                if selectedCategory == .authors {
                    FavoriteAuthorsList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                } else if selectedCategory == .genres {
                    FavoriteGenresList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                } else if selectedCategory == .books {
                    FavoriteBooksList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                } else if selectedCategory == .bookLists {
                    FavoriteBookListsList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                }
            }
            .navigationTitle(Text("Favorites"))
            .searchable(text: $searchTerm)
            .toolbar {
                FavoritesSortOrderPicker(selection: $sortCriteria)
            }
        }
    }
}
