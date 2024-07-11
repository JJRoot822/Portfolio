//
//  BookListBookCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/12/24.
//

import SwiftUI
import CoreData

extension BookListBookCell {
    @Observable
    class ViewModel {
        var error: BookBucketDataError?
        var isShowingAlert: Bool = false
        var isRemoveRequested: Bool = false
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
                self.error = BookBucketDataError.saveError
                isShowingAlert = true
            }
        }
        
        func toggleRequestRemoval() {
            self.isRemoveRequested.toggle()
        }
        
        func toggleRequestDelete() {
            self.isDeleteRequested.toggle()
        }
        
        func remove(context: NSManagedObjectContext, bookList: BookList, book: Book) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.remove(book: book, from: bookList)
            } catch {
                self.error = BookBucketDataError.removeBookFromListError
                isShowingAlert = true
            }
        }
        
        func delete(context: NSManagedObjectContext, book: Book) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.delete(book)
            } catch {
                self.error = BookBucketDataError.deleteError
            }
        }
    }
}
