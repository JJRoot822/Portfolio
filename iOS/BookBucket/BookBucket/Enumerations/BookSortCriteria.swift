//
//  BookSortCriteria.swift
//  BookBucket
//
//  Created by Joshua Root on 3/21/24.
//

import Foundation

enum BookSortCriteria: String {
    case titleAscending = "Title (Ascending)", titleDescending = "Title (Descending)",
         formatAscending = "Book Format (Ascending)", formatDescending = "Book Format (Descending)",
         releaseDateAscending = "Release Date (Ascending)", releaseDateDescending = "Release Date (Descending)",
         numberOfPagesAscending = "Number of Pages (Ascending)", numberOfPagesDescending = "Number of Pages (Descending)",
         numberOfChaptersAscending = "Number of Chapters (Ascending)", numberOfChaptersDescending = "Number of Chapters (Descending)"
}
