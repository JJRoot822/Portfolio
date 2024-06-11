//
//  FavoritesScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/28/24.
//

import SwiftUI

struct FavoritesScreen: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                FavoritesCategoryPicker(selection: $viewModel.selectedCategory)
                
                if viewModel.selectedCategory == .authors {
                    FavoriteAuthorsList(sortCriteria: viewModel.sortCriteria, searchTerm: viewModel.searchTerm)
                } else if viewModel.selectedCategory == .genres {
                    FavoriteGenresList(sortCriteria: viewModel.sortCriteria, searchTerm: viewModel.searchTerm)
                } else if viewModel.selectedCategory == .books {
                    FavoriteBooksList(sortCriteria: viewModel.sortCriteria, searchTerm: viewModel.searchTerm)
                } else if viewModel.selectedCategory == .bookLists {
                    FavoriteBookListsList(sortCriteria: viewModel.sortCriteria, searchTerm: viewModel.searchTerm)
                }
            }
            .navigationTitle(Text("Favorites"))
            .searchable(text: $viewModel.searchTerm)
            .toolbar {
                FavoritesSortOrderPicker(selection: $viewModel.sortCriteria)
            }
        }
    }
}
