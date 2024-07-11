//
//  Author+CoreDataHelper.swift
//  BookBucket
//
//  Created by Joshua Root on 7/1/24.
//

import CoreData

extension Author {
    var authorId: UUID {
        id ?? UUID()
    }
    
    var authorName: String {
        name ?? "Unknown Author"
    }
    
    var authorBooks: [Book] {
        books.allObjects as? [Book]
    }
}
