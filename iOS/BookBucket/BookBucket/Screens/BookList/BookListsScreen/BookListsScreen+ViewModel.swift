//
//  BookListsScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/8/24.
//

import Foundation
import Observation

extension BookListsScreen {
    @Observable
    class ViewModel {
        var sortCriteria: BookListSortCriteria = .nameAscending
        var searchTerm: String = ""
        var id: UUID = UUID()
        var showingAddBookList: Bool = false
        
        func showAddBookListScreen() {
            showingAddBookList = true
        }
    }
}
