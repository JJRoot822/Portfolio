//
//  AddBooksToBookListScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 6/11/24.
//

import SwiftData

extension AddBooksToBookListScreen {
    @Observable
    class ViewModel {
        var selectedBooks = Set<Book>()
        var isShowingSaveError = false
        var shouldDismiss: Bool = false
        
        func cancel() {
            shouldDismiss = true
        }
        
        func addBooksToBookList(context: ModelContext, bookList: BookList) {
            selectedBooks.forEach {
                bookList.books.append($0)
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
