//
//  BookList+CoreDataHelper.swift
//  BookBucket
//
//  Created by Joshua Root on 7/1/24.
//

import CoreData

extension BookList {
    var listId: UUID {
        id ?? UUID()
    }
    
    var listName: String {
        name ?? "Unknown"
    }
    
    var listColor: String {
        color ?? "Blue"
    }
    
    var listBooks: [Book] {
        books?.allObjects as? [Book] ?? []
    }
}
