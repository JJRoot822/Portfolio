//
//  Genre+CoreDataHelper.swift
//  BookBucket
//
//  Created by Joshua Root on 7/1/24.
//

import CoreData

extension Genre {
    var genreId: UUID {
        id ?? UUID()
    }
    
    var genreName: String {
        name ?? "Unknown Genre"
    }
    
    var genreBooks: [Book] {
        books.allObjects as? [Book] ?? []
    }
}
