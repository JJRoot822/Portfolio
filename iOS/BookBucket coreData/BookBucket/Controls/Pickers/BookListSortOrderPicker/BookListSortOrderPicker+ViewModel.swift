//
//  BookListSortOrderPicker+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/15/24.
//

import Foundation

extension BookListsSortOrderPicker {
    class ViewModel {
        let options: [BookListSortCriteria] = [
            .nameAscending, .nameDescending,
            .numberOfBooksAscending, .numberOfBooksDescending
        ]
    }
}
