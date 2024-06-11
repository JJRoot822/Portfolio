//
//  AddAuthorsToBookScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/8/24.
//

import SwiftData

extension AddAuthorsToBookScreen {
    @Observable
    class ViewModel {
        var shouldDismiss: Bool = false
        var selectedAuthors = Set<Author>()
        var isShowingSaveError = false
        
        func addAuthorsToBook(context: ModelContext, book: Book) {
            selectedAuthors.forEach {
                book.authors.append($0)
            }
            
            do {
                try context.save()
                shouldDismiss = true
            } catch {
                isShowingSaveError = true
            }
        }
        
        func cancel() {
            shouldDismiss = true
        }
    }
}
