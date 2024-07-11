//
//  AuthorSortOrderPicker+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/14/24.
//

import Foundation

extension AuthorSortOrderPicker {
    class ViewModel {
        let options: [AuthorSortCriteria] = [
            .nameAscending, .nameDescending,
            .booksAuthoredAscending, .booksAuthoredDescending
        ]
    }
}
