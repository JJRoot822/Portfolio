
//
//  BookCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/12/24.
//

import SwiftUI
import SwiftData

extension BookCell {
    @Observable
    class ViewModel {
        var isShowingDeleteError: Bool = false
        var isShowingSaveError: Bool = false
        var isDeleteRequested: Bool = false
        var isShowingEditBookScreen: Bool = false
        var isShowingEditBookCover: Bool = false

        func getFavoritedStatus(book: Book) -> String {
            return book.isFavorite ? "Favorited" : "Not Favorited"
        }
        
        func getFavoriteIndicatorIcon(book: Book) -> String {
            return book.isFavorite ? "star.fill" : "star"
        }
        
        func getFavoriteToggleLabel(book: Book) -> String {
            return book.isFavorite ? "Remove from Favorites" : "Mark as Favorite"
        }
        
        func getFavoriteIndicatorIconColor(book: Book) -> Color {
            return book.isFavorite ? .yellow : .secondary
        }
        
        func getFavoriteToggleIcon(book: Book) -> String {
            return book.isFavorite ? "star.slash" :"star"
        }
        
        func getReadingProgress(book: Book) -> Float {
            return Float(book.numberOfPagesRead) / Float(book.numberOfPages)
        }
        
        func showEditBookScreen() {
            self.isShowingEditBookScreen = true
        }
        
        func showEditBookCoverScreen() {
            self.isShowingEditBookCover = true
        }
        
        func toggleFavorite(context: ModelContext, book: Book) {
            book.isFavorite.toggle()
            
            saveChanges(context: context)
        }
        
        private func saveChanges(context: ModelContext) {
            let dataHelper = DataHelper()
            let result = dataHelper.save(context: context)
            
            switch result {
            case .success(()):
                return
            case .failure(_):
                if context.hasChanges {
                    context.rollback()
                }
                
                
                self.isShowingSaveError = true
                
                return
            }
        }
        
        func toggleRequestDelete() {
            self.isDeleteRequested.toggle()
        }
        
        func delete(context: ModelContext, book: Book) {
            let dataHelper = DataHelper()
            let result = dataHelper.delete(context: context, model: book)
            
            switch result {
            case .success(()):
                return
            case .failure(_):
                self.isShowingDeleteError = true
                
                return
            }
        }
    }
}
