//
//  AddGenresToBookScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/8/24.
//

import SwiftData

extension AddGenresToBookScreen {
    @Observable
    class ViewModel {
        var selectedGenres = Set<Genre>()
        var isShowingSaveError = false
        var shouldDismiss: Bool = false
    
        func cancel() {
            shouldDismiss = true
        }
        
        func addGenresToBook(context: ModelContext, book: Book) {
            selectedGenres.forEach {
                book.genres.append($0)
            }
            
            do {
                try context.save()
                shouldDismiss = true
            } catch {
                isShowingSaveError = true
            }
        }
    }
    
}
