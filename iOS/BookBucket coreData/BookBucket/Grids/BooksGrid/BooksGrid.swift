//
//  BooksGrid.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI
import CoreData

struct BooksGrid: View {
    @FetchRequest private var books: FetchedResults<Book>
    
    @State private var viewModel = ViewModel()
    
    var sortCriteria: BookSortCriteria
    var searchTerm: String
    
    init(sortCriteria: BookSortCriteria, searchTerm: String) {
        self.sortCriteria = sortCriteria
        self.searchTerm = searchTerm
        
        if searchTerm.isEmpty {
            switch sortCriteria {
            case .titleAscending:
                self._books = FetchRequest(sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.title, ascending: true)
                ], animation: .default)
            case .titleDescending:
                self._books = FetchRequest(sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.title, ascending: false)
                ], animation: .default)
            case .formatAscending:
                self._books = FetchRequest(sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.bookFormat, ascending: true)
                ], animation: .default)
            case .formatDescending:
                self._books = FetchRequest(sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.bookFormat, ascending: false)
                ], animation: .default)
            case .numberOfPagesAscending:
                self._books = FetchRequest(sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.numberOfPages, ascending: true)
                ], animation: .default)
            case .numberOfPagesDescending:
                self._books = FetchRequest(sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.numberOfPages, ascending: false)
                ], animation: .default)
            case .numberOfChaptersAscending:
                self._books = FetchRequest(sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.numberOfChapters, ascending: true)
                ], animation: .default)
            case .numberOfChaptersDescending:
                self._books = FetchRequest(sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.numberOfChapters, ascending: false)
                ], animation: .default)
            case .releaseDateAscending:
                self._books = FetchRequest(sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.releaseDate, ascending: true)
                ], animation: .default)
            case .releaseDateDescending:
                self._books = FetchRequest(sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.releaseDate, ascending: false)
                ], animation: .default)
            }
        } else {
            switch sortCriteria {
            case .titleAscending:
                self._books = FetchRequest(
                    sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.title, ascending: true)
                    ],
                    predicate: NSPredicate(format: "title contains %@", searchTerm),
                    animation: .default
                )
            case .titleDescending:
                self._books = FetchRequest(
                    sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.title, ascending: false)
                    ],
                    predicate: NSPredicate(format: "title contains %@", searchTerm),
                    animation: .default
                )
            case .formatAscending:
                self._books = FetchRequest(
                    sortDescriptors: [
                        NSSortDescriptor(keyPath: \Book.bookFormat, ascending: true)
                    ],
                    predicate: NSPredicate(format: "title contains %@", searchTerm),
                    animation: .default
                )
            case .formatDescending:
                self._books = FetchRequest(
                    sortDescriptors: [
                        NSSortDescriptor(keyPath: \Book.bookFormat, ascending: false)
                    ],
                    predicate: NSPredicate(format: "title contains %@", searchTerm),
                    animation: .default
                )
            case .numberOfPagesAscending:
                self._books = FetchRequest(
                    sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.numberOfPages, ascending: true)
                    ],
                    predicate: NSPredicate(format: "title contains %@", searchTerm),
                    animation: .default
                )
            case .numberOfPagesDescending:
                self._books = FetchRequest(
                    sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.numberOfPages, ascending: false)
                    ],
                    predicate: NSPredicate(format: "title contains %@", searchTerm),
                    animation: .default
                )
            case .numberOfChaptersAscending:
                self._books = FetchRequest(
                    sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.numberOfChapters, ascending: true)
                    ],
                    predicate: NSPredicate(format: "title contains %@", searchTerm),
                    animation: .default
                )
            case .numberOfChaptersDescending:
                self._books = FetchRequest(
                    sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.numberOfChapters, ascending: false)
                    ],
                    predicate: NSPredicate(format: "title contains %@", searchTerm),
                    animation: .default
                )
            case .releaseDateAscending:
                self._books = FetchRequest(
                    sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.releaseDate, ascending: true)
                    ],
                    predicate: NSPredicate(format: "title contains %@", searchTerm),
                    animation: .default
                )
            case .releaseDateDescending:
                self._books = FetchRequest(
                    sortDescriptors: [
                    NSSortDescriptor(keyPath: \Book.releaseDate, ascending: false)
                    ],
                    predicate: NSPredicate(format: "title contains %@", searchTerm),
                    animation: .default
                )
            }
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: viewModel.columns, spacing: 20) {
                ForEach(books) { book in
                    BookCell(book: book)
                }
            }
        }
        .overlay {
            if books.count == 0 && !searchTerm.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            }
            
            if books.count == 0 && searchTerm.isEmpty {
                Text("Nothing to Show Right Now. Tap the Add Button to Insert a New Book")
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}
