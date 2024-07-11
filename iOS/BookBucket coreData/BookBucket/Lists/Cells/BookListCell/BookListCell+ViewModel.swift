//
//  BookListCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/13/24.
//

import SwiftUI
import CoreData

extension BookListCell {
    @Observable
    class ViewModel {
        var showingEditSheet: Bool = false
        var isDeleteRequested: Bool = false
        var isShowingAlert: Bool = false
        var error: BookBucketDataError?
        
        func getFavoriteButtonTitle(bookList: BookList) -> String {
            return bookList.isFavorite ? "Remove from Favorites" : "Add to Favorites"
        }
        
        func getFavoriteButtonIcon(bookList: BookList) -> String {
            return bookList.isFavorite ? "star.slash" : "star"
        }

        func getFavoriteIndicatorIcon(bookList: BookList) -> String {
            return bookList.isFavorite ? "star.fill" : "star"
        }
        
        func getFavoriteIndicatorLabel(bookList: BookList) -> String {
            return bookList.isFavorite ? "Favorited" : "Not Favorited"
        }
        
        func getFavoriteIndicatorColor(bookList: BookList) -> Color {
            return bookList.isFavorite ? .yellow : .secondary
        }
        
        func toggleEditSheet() {
            self.showingEditSheet = true
        }
        
        func delete(context: NSManagedObjectContext, bookList: BookList) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.delete(bookList)
            } catch {
                self.error = BookBucketDataError.deleteError
                isShowingAlert = true
            }
        }
        
        func toggleRequestDelete() {
            self.isDeleteRequested = true
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
        
        func toggleFavorite(context: NSManagedObjectContext, bookList: BookList) {
            bookList.isFavorite.toggle()
            
            saveChanges(context: context)
        }
    }
}
