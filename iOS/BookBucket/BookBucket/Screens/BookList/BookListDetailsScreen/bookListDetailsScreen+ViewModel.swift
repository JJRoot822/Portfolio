//
//  bookListDetailsScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/10/24.
//

import SwiftUI

extension BookListDetailsScreen {
    @Observable
    class ViewModel {
        var isShowingAddBooksToListScreen: Bool = false
        var sortCriteria: BookSortCriteria = .titleAscending
        var searchTerm: String = ""
        var id: UUID = UUID()
        
        func showAddBookToListScreen() {
            self.isShowingAddBooksToListScreen = true
        }
    }
}
