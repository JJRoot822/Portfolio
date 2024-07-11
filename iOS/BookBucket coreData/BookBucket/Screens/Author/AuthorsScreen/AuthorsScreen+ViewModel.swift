//
//  AuthorsScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 5/29/24.
//

import SwiftUI
import Observation

extension AuthorsScreen {
    @Observable
    class ViewModel {
        var sortCriteria: AuthorSortCriteria = .nameAscending
        var searchTerm: String = ""
        var id: UUID = UUID()
        var showingAddAuthor: Bool = false
        
        func forceRefresh() {
            id = UUID()
        }
        
        func showAddAuthorScreen() {
            self.showingAddAuthor = true
        }
    }
}
