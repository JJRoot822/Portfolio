//
//  FavoriteSortOrderPicker+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/15/24.
//

import Foundation

extension FavoritesSortOrderPicker {
    class ViewModel {
        let options: [FavoritesSortCriteria] = [
            .nameAscending, .nameDescending
        ]
    }
}
