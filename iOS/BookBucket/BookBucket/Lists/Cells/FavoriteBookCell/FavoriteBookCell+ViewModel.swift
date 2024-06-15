//
//  FavoriteBookCell+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/13/24.
//

import SwiftData
import SwiftUI

extension FavoriteBookCell {
    @Observable
    class ViewModel {
        var showingEditSheet: Bool = false
        var isDeleteRequested: Bool = false
        var isShowingError: Bool = false
        var isShowingSaveError: Bool = false
        
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
        
        func getReadingProgress(book: Book) -> Float {
            return Float(book.numberOfPagesRead) / Float(book.numberOfPages)
        }
        
        func toggleEditSheet() {
            self.showingEditSheet = true
        }
        
        func delete(context: ModelContext, book: Book) {
            let dataService = DataService(context: context)
            let result = dataService.delete(model: book)
            
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
            let dataService = DataService(context: context)
            let result = dataService.save()
            
            switch result {
            case .success(()):
                return
            case .failure(_):
                self.isShowingSaveError = true
            }
        }
        
        func toggleFavorite(context: ModelContext, book: Book) {
            book.isFavorite.toggle()
            
            saveChanges(context: context)
        }
    }
}
