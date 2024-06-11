//
//  GenresScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/11/24.
//

import SwiftUI

extension GenresScreen {
    @Observable
    class ViewModel {
        var sortCriteria: GenreSortCriteria = .nameAscending
        var searchTerm: String = ""
        var id: UUID = UUID()
        var showingAddGenre: Bool = false
        
        func showAddGenreScreen() {
            showingAddGenre = true
        }
    }
}
