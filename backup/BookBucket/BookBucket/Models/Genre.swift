//
//  Genre.swift
//  BookBucket
//
//  Created by Joshua Root on 2/19/24.
//

import Foundation
import SwiftData

@Model
class Genre {
    var id: UUID = UUID()
    var name: String
    @Relationship(inverse: \Book.genres) var books: [Book]
    
    
    init (name: String, books: [Book]) {
        self.name = name
        self.books = books
    }}
