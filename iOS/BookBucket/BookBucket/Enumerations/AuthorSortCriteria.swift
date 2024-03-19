//
//  AuthorSortCriteria.swift
//  BookBucket
//
//  Created by Joshua Root on 3/8/24.
//

import Foundation

enum AuthorSortCriteria: String, Hashable {
    case nameAscending = "Author Name (Ascending)",
         nameDescending = "Author Name (Descending)",
         booksAuthoredAscending = "Books Authored (Ascending)",
         booksAuthoredDescending = "Books Authored (Descending)"
}


