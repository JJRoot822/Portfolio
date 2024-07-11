//
//  FavoriteBookCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/13/24.
//

import CoreData
import SwiftUI

extension FavoriteBookCell {
    @Observable
    class ViewModel {
        var showingEditSheet: Bool = false
        var isDeleteRequested: Bool = false
        var isShowingAlert: Bool = false
        var error: BookBucketDataError?
        
        func getFavoriteButtonTitle(book: Book) -> String {
            return book.isFavorite ? "Remove from Favorites" : "Add to Favorites"
        }
        
        func getFavoriteButtonIcon(book: Book) -> String {
            return book.isFavorite ? "star.slash" : "star"
        }
        
        func getBookCoverImage(book: Book) -> Image {
            if let imageData = book.coverImage,
               let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
            
            return Image(systemName: "book.closed")
        }
        
        func toggleEditSheet() {
            self.showingEditSheet = true
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
        
        func toggleFavorite(context: NSManagedObjectContext, book: Book) {
            book.isFavorite.toggle()
            
            saveChanges(context: context)
        }
    }
}
