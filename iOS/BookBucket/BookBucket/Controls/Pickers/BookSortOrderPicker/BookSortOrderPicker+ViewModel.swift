//
//  BookSortOrderPicker+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/15/24.
//

import Foundation

extension BookSortOrderPicker {
    class ViewModel {
        let options: [BookSortCriteria] = [
            .titleAscending, .titleDescending,
            .formatAscending, .formatDescending,
            .numberOfChaptersAscending, .numberOfChaptersDescending,
            .numberOfPagesAscending, .numberOfPagesDescending,
            .releaseDateAscending, .releaseDateDescending
        ]
    }
}
