
//
//  BookCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/12/24.
//

import SwiftUI
import CoreData

extension BookCell {
    @Observable
    class ViewModel {
        var error: BookBucketDataError?
        var isShowingAlert: Bool = false
        var isDeleteRequested: Bool = false
        var isShowingEditBookScreen: Bool = false

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
        
        func showEditBookScreen() {
            self.isShowingEditBookScreen = true
        }
        
        func toggleFavorite(context: NSManagedObjectContext, book: Book) {
            book.isFavorite.toggle()
            
            saveChanges(context: context)
        }
        
        func saveChanges(context: NSManagedObjectContext) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.save()
            } catch {
                if context.hasChanges {
                    context.rollback()
                    
                    self.error = BookBucketDataError.saveError
                    isShowingAlert = true
                }
            }
        }
        
        func toggleRequestDelete() {
            self.isDeleteRequested.toggle()
        }
        
        func delete(context: NSManagedObjectContext, book: Book) {
            let dataService = DataService(context: context)
            do {
                try dataService.delete(book)
            } catch {
                self.error = BookBucketDataError.deleteError
                isShowingAlert = true
            }
        }
    }
}
