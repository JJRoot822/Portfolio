//
//  BookDetailsScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/7/24.
//

import Observation
import SwiftUI
extension BookDetailsScreen {
    @Observable
    class ViewModel {
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .none
            
            return formatter
        }
        
        var showAddAuthorsToBook = false
        var showAddGenresToBook = false
        var id: UUID = UUID()
        
        func showAddAuthorsToBookScreen() {
            showAddAuthorsToBook = true
        }
        
        func showAddGenresToBookScreen() {
            showAddGenresToBook = true
        }
    }
}
