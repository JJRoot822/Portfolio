//
//  File.swift
//  BookBucket
//
//  Created by Joshua Root on 2/19/24.
//

import Foundation
import SwiftData

@Model
class Book {
    var id = UUID()
    var title: String
    var isFavorite: Bool
    var bookFormat: String
    var releaseDate: Date
    var list: BookList
    var authors: [Author]
    var genres: [Genre]
    init (title: String, isFavorite: Bool, bookFormat: String, releaseDate: Date, list: BookList, authors: [Author], genres: [Genre]) {
        self.title = title
        self.genres = genres
        self.isFavorite = isFavorite
        self.bookFormat = bookFormat
        self.releaseDate = releaseDate
        self.list = list
        self.authors = authors
    }
}
