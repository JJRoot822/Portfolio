//
//  BooksGrid.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI
import SwiftData

struct BooksGrid: View {
    @Query private var books: [Book]
    
    @State private var viewModel = ViewModel()
    
    var sortCriteria: BookSortCriteria
    var searchTerm: String
    
    init(sortCriteria: BookSortCriteria, searchTerm: String) {
        self.sortCriteria = sortCriteria
        self.searchTerm = searchTerm
        
        if searchTerm.isEmpty {
            switch sortCriteria {
            case .titleAscending:
                self._books = Query(sort: \Book.title)
            case .titleDescending:
                self._books = Query(sort: \Book.title, order: .reverse)
            case .formatAscending:
                self._books = Query(sort: \Book.bookFormat)
            case .formatDescending:
                self._books = Query(sort: \Book.bookFormat, order: .reverse)
            case .numberOfPagesAscending:
                self._books = Query(sort: \Book.numberOfPages)
            case .numberOfPagesDescending:
                self._books = Query(sort: \Book.numberOfPages, order: .reverse)
            case .numberOfChaptersAscending:
                self._books = Query(sort: \Book.numberOfChapters)
            case .numberOfChaptersDescending:
                self._books = Query(sort: \Book.numberOfChapters, order: .reverse)
            case .releaseDateAscending:
                self._books = Query(sort: \Book.releaseDate)
            case .releaseDateDescending:
                self._books = Query(sort: \Book.releaseDate, order: .reverse)
            }
        } else {
            switch sortCriteria {
            case .titleAscending:
                self._books = Query(filter: #Predicate<Book>{ book in
                    book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.title, order: .forward)])
            case .titleDescending:
                self._books = Query(filter: #Predicate<Book> { book in
                    book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.title, order: .reverse)])
            case .formatAscending:
                self._books = Query(filter: #Predicate<Book>{ book in
                    book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.bookFormat, order: .forward)])
            case .formatDescending:
                self._books = Query(filter: #Predicate<Book> { book in
                    book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.bookFormat, order: .reverse)])
            case .numberOfPagesAscending:
                self._books = Query(filter: #Predicate<Book>{ book in
                    book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.numberOfPages, order: .forward)])
            case .numberOfPagesDescending:
                self._books = Query(filter: #Predicate<Book> { book in
                    book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.numberOfPages, order: .reverse)])
            case .numberOfChaptersAscending:
                self._books = Query(filter: #Predicate<Book>{ book in
                    book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.numberOfChapters, order: .forward)])
            case .numberOfChaptersDescending:
                self._books = Query(filter: #Predicate<Book> { book in
                    book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.numberOfChapters, order: .reverse)])
            case .releaseDateAscending:
                self._books = Query(filter: #Predicate<Book>{ book in
                    book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.releaseDate, order: .forward)])
            case .releaseDateDescending:
                self._books = Query(filter: #Predicate<Book> { book in
                    book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.releaseDate, order: .reverse)])
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
