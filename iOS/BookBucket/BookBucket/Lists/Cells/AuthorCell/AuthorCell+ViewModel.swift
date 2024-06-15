//
//  AuthorCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/13/24.
//

import SwiftUI
import SwiftData

extension AuthorCell {
    @Observable
    class ViewModel {
        var showingEditSheet: Bool = false
        var isDeleteRequested: Bool = false
        var isShowingError: Bool = false
        var isShowingSaveError: Bool = false
        
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
        
        func delete(context: ModelContext, author: Author) {
            let dataService = DataService(context: context)
            let result = dataService.delete(model: author)
            
            switch result {
            case .success(()):
                return
            case .failure(_):
                self.isShowingError = true
            }
        }
        
        func toggleRequestDelete() {
            self.isDeleteRequested.toggle()
        }
        
        func toggleFavorite(context: ModelContext, author: Author) {
            author.isFavorited.toggle()
        
            saveChanges(context: context)
        }
        
        func saveChanges(context: ModelContext) {
            let dataService = DataService(context: context)
            let result = dataService.save()
            
            switch result {
            case .success(()):
                return
            case .failure(_):
                self.isShowingSaveError = true
            }
        }
    }
}
