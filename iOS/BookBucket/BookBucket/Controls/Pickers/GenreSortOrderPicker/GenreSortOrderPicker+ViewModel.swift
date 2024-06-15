//
//  GenreSortOrderPicker+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/15/24.
//

import Foundation

extension GenreSortOrderPicker {
    class ViewModel {
        let options: [GenreSortCriteria] = [
            .nameAscending, .nameDescending,
            .numberOfBooksAscending, .numberOfBooksDescending
        ]
    }
}
