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
    @Relationship(inverse: \Book.bookLists) var books: [Book]
    
    init (title: String, color: String, books: [Book]) {
        self.title = title
        self.color = color
        self.books = books
    }
}
