//
//  Book.swift
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
    var numberOfChapters: Int
    var numberOfPages: Int
    var numberOfChaptersRead: Int
    var numberOfPagesRead: Int
    var isReading: Bool
    var isCompleted: Bool
    @Attribute(.externalStorage) var coverImage: Data?
    var bookLists: [BookList]
    var authors: [Author]
    var genres: [Genre]
    
    init (title: String, isFavorite: Bool, bookFormat: String, 
          releaseDate: Date, numberOfPages: Int, numberOfChapters: Int, 
          numberOfChaptersRead: Int, numberOfPagesRead: Int, isReading: Bool,
          isCompleted: Bool, coverImage: Data?, bookLists: [BookList],
          authors: [Author], genres: [Genre]) {
        self.title = title
        self.genres = genres
        self.isFavorite = isFavorite
        self.bookFormat = bookFormat
        self.releaseDate = releaseDate
        self.numberOfPages = numberOfPages
        self.numberOfChapters = numberOfChapters
        self.numberOfPagesRead = numberOfPagesRead
        self.numberOfChaptersRead = numberOfChaptersRead
        self.isReading = isReading
        self.isCompleted = isCompleted
        self.coverImage = coverImage
        self.bookLists = bookLists
        self.authors = authors
    }
 }
