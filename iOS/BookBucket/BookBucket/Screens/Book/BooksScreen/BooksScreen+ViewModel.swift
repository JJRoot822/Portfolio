//
//  BooksScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/7/24.
//

import Observation

extension BooksScreen {
    @Observable
    class ViewModel {
        var sortCriteria: BookSortCriteria = .titleAscending
        var searchTerm: String = ""
        var isShowingAddBookScreen: Bool = false
        
        func showAddBookScreen() {
            isShowingAddBookScreen = true
        }
    }
}
