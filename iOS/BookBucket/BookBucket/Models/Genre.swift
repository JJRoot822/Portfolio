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
    var isFavorite: Bool
    @Relationship(inverse: \Book.genres) var books: [Book]
    
    init (name: String, isFavorite: Bool, books: [Book]) {
        self.name = name
        self.isFavorite = isFavorite
        self.books = books
    }}
