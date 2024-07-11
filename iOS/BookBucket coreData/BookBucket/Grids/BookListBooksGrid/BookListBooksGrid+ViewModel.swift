//
//  BookListBooksGrid+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/12/24.
//

import SwiftUI

extension BookListBooksGrid {
    @Observable
    class ViewModel {
        init() {
            self.books = []
        }
        
        var books: [Book]
        
        
        let columns = [
            GridItem(.adaptive(minimum: 125, maximum: 150))
        ]
    }
}
