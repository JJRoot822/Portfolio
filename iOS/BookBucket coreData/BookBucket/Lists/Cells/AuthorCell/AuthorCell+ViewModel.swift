//
//  AuthorCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/13/24.
//

import SwiftUI
import CoreData

extension AuthorCell {
    @Observable
    class ViewModel {
        var showingEditSheet: Bool = false
        var isDeleteRequested: Bool = false
        var isShowingAlert: Bool = false
        var error: BookBucketDataError?
        
        func getFavoriteButtonTitle(author: Author) -> String {
            return author.isFavorited ? "Remove from Favorites" : "Add to Favorites"
        }
        
        func getFavoriteButtonIcon(author: Author) -> String {
            return author.isFavorited ? "star.slash" : "star"
        }
        
        func getFavoriteIndicatorIcon(author: Author) -> String {
            return author.isFavorited ? "star.fill" : "star"
        }
        
        func getFavoriteIndicatorLabel(author: Author) -> String {
            return author.isFavorited ? "Favorited" : "Not Favorited"
        }
        
        func getFavoriteIndicatorColor(author: Author) -> Color {
            return author.isFavorited ? .yellow : .secondary
        }
        
        func toggleEditSheet() {
            self.showingEditSheet = true
        }
        
        func delete(context: NSManagedObjectContext, author: Author) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.delete(author)
            } catch {
                self.error = BookBucketDataError.deleteError
                isShowingAlert = true
            }
        }
        
        func toggleRequestDelete() {
            self.isDeleteRequested.toggle()
        }
        
        func toggleFavorite(context: NSManagedObjectContext, author: Author) {
            author.isFavorited.toggle()
        
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
    }
}
