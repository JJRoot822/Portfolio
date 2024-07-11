//
//  Book+CoreDataHelper.swift
//  BookBucket
//
//  Created by Joshua Root on 7/1/24.
//

import UIKit
import CoreData

extension Book {
    var bookId: UUID {
        id ?? UUID()
    }
    
    var bookTitle: String {
        title ?? "Unknown"
    }
    
    var bookKind: String {
        bookFormat ?? "Unknown Format"
    }
    
    var bookReleaseDate: Date {
        releaseDate ?? Date()
    }
    
    var bookISBN: String {
        isbn ?? "No ISBN Provided"
    }
    
    var bookAuthors: [Author] {
        authors.allObjects as? [Author] ?? []
    }
    
    var bookGenres: [Genre] {
        genres.allObjects as [Genre] ?? []
    }
    
    var lists: [BookList] {
        bookLists as? [BookList] ?? []
    }
}
