//
//  GenreCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/13/24.
//

import SwiftUI
import SwiftData

extension GenreCell {
    @Observable
    class ViewModel {
        var showingEditSheet: Bool = false
        var isDeleteRequested: Bool = false
        var isShowingError: Bool = false
        var isShowingSaveError: Bool = false

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
        
        func delete(context: ModelContext, genre: Genre) {
            let dataHelper = DataHelper()
            let result = dataHelper.delete(context: context, model: genre)
            
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
        
        func saveChanges(context: ModelContext) {
            let dataHelper = DataHelper()
            let result = dataHelper.save(context: context)
            
            switch result {
            case .success(()):
                return
            case .failure(_):
                self.isShowingSaveError = true
            }
        }
        
        func toggleFavorite(context: ModelContext, genre: Genre) {
            genre.isFavorite.toggle()
            
            saveChanges(context: context)
        }
    }
}
