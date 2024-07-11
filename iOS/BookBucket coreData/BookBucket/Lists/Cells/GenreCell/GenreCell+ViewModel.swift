//
//  GenreCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/13/24.
//

import SwiftUI
import CoreData

extension GenreCell {
    @Observable
    class ViewModel {
        var showingEditSheet: Bool = false
        var isDeleteRequested: Bool = false
        var isShowingAlert: Bool = false
        var error: BookBucketDataError?
        
        func getFavoriteButtonTitle(genre: Genre) -> String {
            return genre.isFavorite ? "Remove from Favorites" : "Add to Favorites"
        }
        
        func getFavoriteButtonIcon(genre: Genre) -> String {
            return genre.isFavorite ? "star.slash" : "star"
        }
        
        func getFavoriteIndicatorIcon(genre: Genre) -> String {
            return genre.isFavorite ? "star.fill" : "star"
        }
        
        func getFavoriteIndicatorLabel(genre: Genre) -> String {
            return genre.isFavorite ? "Favorited" : "Not Favorited"
        }
        
        func getFavoriteIndicatorColor(genre: Genre) -> Color {
            return genre.isFavorite ? .yellow : .secondary
        }
        
        func toggleEditSheet() {
            self.showingEditSheet = true
        }
        
        func delete(context: NSManagedObjectContext, genre: Genre) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.delete(genre)
            } catch {
                self.error = BookBucketDataError.deleteError
                self.isShowingAlert = true
            }
        }
        
        func toggleRequestDelete() {
            self.isDeleteRequested.toggle()
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
        
        func toggleFavorite(context: NSManagedObjectContext, genre: Genre) {
            genre.isFavorite.toggle()
            
            saveChanges(context: context)
        }
    }
}
