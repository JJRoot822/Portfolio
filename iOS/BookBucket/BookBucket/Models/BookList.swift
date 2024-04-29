//
//  BookList.swift
//  BookBucket
//
//  Created by Joshua Root on 2/19/24.
//

import Foundation
import SwiftData

@Model
class BookList {
    var id: UUID = UUID()
    var title: String
    var color: String
    var isFavorite: Bool
    @Relationship(inverse: \Book.bookLists) var books: [Book]
    
    init (title: String, color: String, isFavorite: Bool, books: [Book]) {
        self.title = title
        self.color = color
        self.isFavorite = isFavorite
        self.books = books
    }
}
