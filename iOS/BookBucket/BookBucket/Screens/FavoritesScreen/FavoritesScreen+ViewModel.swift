//
//  FavoritesScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/10/24.
//

import SwiftUI

extension FavoritesScreen {
    @Observable
    class ViewModel {
        var sortCriteria: FavoritesSortCriteria = .nameAscending
        var selectedCategory: Category = .authors
        var searchTerm: String = ""
    }
}
