//
//  BookBucketDataError.swift
//  BookBucket
//
//  Created by Joshua Root on 7/2/24.
//

import Foundation

enum BookBucketDataError: LocalizedError, Identifiable {
    case saveError, deleteError, insertError, 
         addBookToListError, addAuthorToBookError, addGenreToBookError,
         removeBookFromListError, removeAuthorFromBookError, removeGenreFromBookError
    
    var id: Int {
        switch self {
        case .insertError:
            return 1
        case .deleteError:
            return 2
        case .saveError:
            return 3
        case .addAuthorToBookError:
            return 4
        case .addGenreToBookError:
            return 5
        case .addBookToListError:
            return 6
        case .removeBookFromListError:
            return 7
        case .removeGenreFromBookError:
            return 8
        case .removeAuthorFromBookError:
            return 9
        }
    }
    
    var failureReason: String? {
        switch self {
        case .saveError:
            return "There was an issue when trying to save the changes you made. Please try again later."
        case .deleteError:
            return "There was an issue when trying to delete the object you requested. Please try again later."
        case .insertError:
            return "There was an issue when trying to insert the object you requested. Please try again later."
        case .addBookToListError:
            return "There was an issue when trying to add the selected book to the book list you requested. Please try again later."
        case .addGenreToBookError:
            return "There was an issue when trying to add the selected genres to the book you requested. Please try again later."
        case .addAuthorToBookError:
            return "There was an issue when trying to add the selected authors to the book you requested. Please try again later."
        case .removeBookFromListError:
            return "There was an issue when trying to remove the selected book from the book list you requested. Please try again later."
        case .removeAuthorFromBookError:
            return "There was an issue when trying to remove the selected authors from the book you requested. Please try again later."
        case .removeGenreFromBookError:
            return "There was an issue when trying to remove the selected genres from the book you requested. Please try again later."
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .saveError:
            return "Failed to Save Changes"
        case .deleteError:
            return "Failed to Delete"
        case .insertError:
            return "Failed to Insert Data"
        case .addAuthorToBookError:
            return "Failed to Add Selected Authors"
        case .addBookToListError:
            return "Failed to Add Book"
        case .addGenreToBookError:
            return "Failed to Add Selected Genres"
        case .removeBookFromListError:
            return "Failed to Remove From Book List"
        case .removeAuthorFromBookError:
            return "Failed to Remove From Book"
        case .removeGenreFromBookError:
            return "Failed to Remove From Book"
        }
    }
}
