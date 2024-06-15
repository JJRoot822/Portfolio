//
//  BookListBookCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/12/24.
//

import SwiftUI
import SwiftData

extension BookListBookCell {
    @Observable
    class ViewModel {
        var isShowingDeleteError: Bool = false
        var isShowingRemoveError: Bool = false
        var isRemoveRequested: Bool = false
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
        
        func getFavoriteIndicatorColor(book: Book) -> Color {
            return book.isFavorite ? Color.yellow : Color.secondary
        }
        
        func getFavoriteToggleLabel(book: Book) -> String {
            return book.isFavorite ? "Remove from Favorites" : "Mark as Favorite"
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
        
        func saveChanges(context: ModelContext) {
            let dataService = DataService(context: context)
            let result = dataService.save()
            
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
        
        func toggleRequestRemoval() {
            self.isRemoveRequested.toggle()
        }
        
        func toggleRequestDelete() {
            self.isDeleteRequested.toggle()
        }
        
        func remove(context: ModelContext, bookList: BookList, book: Book) {
            let indexToRemove = bookList.books.firstIndex(of: book)
            
            if let index = indexToRemove {
                bookList.books.remove(at: index)
                saveChanges(context: context)
                
                return
            }
            
            self.isShowingRemoveError = true
        }
        
        func delete(context: ModelContext, book: Book) {
            let dataService = DataService(context: context)
            let result = dataService.delete(model: book)
            
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
