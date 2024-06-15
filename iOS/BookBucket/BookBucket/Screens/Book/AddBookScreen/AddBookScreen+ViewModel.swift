//
//  AddBookScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 5/30/24.
//

import SwiftUI
import SwiftData

extension AddBookScreen {
    @Observable
    class ViewModel {
        var bookTitle: String = ""
        var bookFormat: String = "Print"
        var bookReleaseDate: Date = Date()
        var bookCoverImageData: Data? = nil
        var isFavoriteBook: Bool = false
        var numberOfPages: Int = 0
        var numberOfChapters: Int = 0
        var numberOfPagesRead: Int = 0
        var numberOfChaptersRead: Int = 0
        var isCurrentlyReadingBook = false
        var hasCompletedBook: Bool = false
        var isShowingError: Bool = false
        var isShowingRequirementsPopover: Bool = false
        var shouldDismiss: Bool = false
        
        var integerFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            
            return formatter
        }
        
        func toggleRequirementsPopover() {
            isShowingRequirementsPopover.toggle()
        }
        
        func cancel() {
            shouldDismiss = true
        }
        
        func create(context: ModelContext) {
            let book = Book(title: bookTitle, isFavorite: isFavoriteBook, bookFormat: bookFormat, releaseDate: bookReleaseDate, numberOfPages: numberOfPages, numberOfChapters: numberOfChapters, numberOfChaptersRead: numberOfChaptersRead, numberOfPagesRead: numberOfPagesRead, isReading: isCurrentlyReadingBook, isCompleted: hasCompletedBook, coverImage: bookCoverImageData, bookLists: [], authors: [], genres: [])
            let dataService = DataService(context: context)
            let result = dataService.insert(model: book)
            
            switch result {
            case .success(()):
                shouldDismiss = true
                return
            case .failure(_):
                if context.hasChanges {
                    context.rollback()
                }
                
                isShowingError = true
            }
        }
    }
}
