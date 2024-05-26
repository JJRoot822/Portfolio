//
//  BookListBooksGrid.swift
//  BookBucket
//
//  Created by Joshua Root on 5/24/24.
//

import SwiftUI
import SwiftData

struct BookListBooksGrid: View {
    @State private var books: [Book]
    
    var bookList: BookList
    var sortCriteria: BookSortCriteria
    var searchTerm: String
    
    init(bookList: BookList, sortCriteria: BookSortCriteria, searchTerm: String) {
        self.sortCriteria = sortCriteria
        self.bookList = bookList
        self.searchTerm = searchTerm
        
        if searchTerm.isEmpty {
            switch sortCriteria {
            case .titleAscending:
                self._books = State(wrappedValue: bookList.books.sorted {
                    $0.title < $1.title
                })
            case .titleDescending:
                self._books = State(wrappedValue: bookList.books.sorted {
                    $0.title > $1.title
                })
            case .formatAscending:
                self._books = State(wrappedValue: bookList.books.sorted {
                    $0.bookFormat < $1.bookFormat
                })
            case .formatDescending:
                self._books = State(wrappedValue: bookList.books.sorted {
                    $0.bookFormat > $1.bookFormat
                })
            case .numberOfPagesAscending:
                self._books = State(wrappedValue: bookList.books.sorted {
                    $0.numberOfPages < $1.numberOfPages
                })
            case .numberOfPagesDescending:
                self._books = State(wrappedValue: bookList.books.sorted {
                    $0.numberOfPages > $1.numberOfPages
                })
            case .numberOfChaptersAscending:
                self._books = State(wrappedValue: bookList.books.sorted {
                    $0.numberOfChapters < $1.numberOfChapters
                })
            case .numberOfChaptersDescending:
                self._books = State(wrappedValue: bookList.books.sorted {
                    $0.numberOfChapters > $1.numberOfChapters
                })
            case .releaseDateAscending:
                self._books = State(wrappedValue: bookList.books.sorted {
                    $0.releaseDate < $1.releaseDate
                })
            case .releaseDateDescending:
                self._books = State(wrappedValue: bookList.books.sorted {
                    $0.releaseDate > $1.releaseDate
                })
            }
        } else {
            switch sortCriteria {
            case .titleAscending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                self._books = State(wrappedValue: filteredBooks.sorted {
                    $0.title < $1.title
                })
            case .titleDescending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                self._books = State(wrappedValue: filteredBooks.sorted {
                    $0.title > $1.title
                })
            case .formatAscending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                self._books = State(wrappedValue: filteredBooks.sorted {
                    $0.bookFormat < $1.bookFormat
                })
            case .formatDescending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                self._books = State(wrappedValue: filteredBooks.sorted {
                    $0.bookFormat > $1.bookFormat
                })
            case .numberOfPagesAscending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                self._books = State(wrappedValue: filteredBooks.sorted {
                    $0.numberOfPages < $1.numberOfPages
                })
            case .numberOfPagesDescending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                self._books = State(wrappedValue: filteredBooks.sorted {
                    $0.numberOfPages > $1.numberOfPages
                })
            case .numberOfChaptersAscending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                self._books = State(wrappedValue: filteredBooks.sorted {
                    $0.numberOfChapters < $1.numberOfChapters
                })
            case .numberOfChaptersDescending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                self._books = State(wrappedValue: filteredBooks.sorted {
                    $0.numberOfChapters > $1.numberOfChapters
                })
            case .releaseDateAscending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                self._books = State(wrappedValue: filteredBooks.sorted {
                    $0.releaseDate < $1.releaseDate
                })
            case .releaseDateDescending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                self._books = State(wrappedValue: filteredBooks.sorted {
                    $0.releaseDate > $1.releaseDate
                })
            }
        }
    }
    
    let columns = [
        GridItem(.adaptive(minimum: 125, maximum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(books) { book in
                    BookListBookCell(bookList: bookList, book: book)
                }
            }
        }
        .overlay {
            if books.count == 0 && !searchTerm.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            }
            
            if books.count == 0 && searchTerm.isEmpty {
                Text("Nothing to Show Right Now. Tap the Add Button to Add a Book to This Book List")
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}
