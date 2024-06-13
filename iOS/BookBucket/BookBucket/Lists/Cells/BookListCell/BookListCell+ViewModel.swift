//
//  BookListCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/13/24.
//

import SwiftUI
import SwiftData

extension BookListCell {
    @Observable
    class ViewModel {
        var showingEditSheet: Bool = false
        var isDeleteRequested: Bool = false
        var isShowingError: Bool = false
        var isShowingSaveError: Bool = false
        
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
        
        func delete(context: ModelContext, bookList: BookList) {
            let dataHelper = DataHelper()
            let result = dataHelper.delete(context: context, model: bookList)
            
            switch result {
            case .success(()):
                return
            case .failure(_):
                self.isShowingError = true
            }
        }
        
        func toggleRequestDelete() {
            self.isDeleteRequested = true
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
        
        func toggleFavorite(context: ModelContext, bookList: BookList) {
            bookList.isFavorite.toggle()
            
            saveChanges(context: context)
        }
    }
}
