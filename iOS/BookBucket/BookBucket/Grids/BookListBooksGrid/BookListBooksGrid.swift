//
//  BookListBooksGrid.swift
//  BookBucket
//
//  Created by Joshua Root on 5/24/24.
//

import SwiftUI
import SwiftData

struct BookListBooksGrid: View {
    @State private var viewModel: ViewModel
    
    var bookList: BookList
    var sortCriteria: BookSortCriteria
    var searchTerm: String
    
    init(bookList: BookList, sortCriteria: BookSortCriteria, searchTerm: String) {
        let viewModel = ViewModel()
        
        self.sortCriteria = sortCriteria
        self.bookList = bookList
        self.searchTerm = searchTerm
        
        if searchTerm.isEmpty {
            switch sortCriteria {
            case .titleAscending:
                viewModel.books = bookList.books.sorted {
                    $0.title < $1.title
                }
            case .titleDescending:
                viewModel.books = bookList.books.sorted {
                    $0.title > $1.title
                }
            case .formatAscending:
                viewModel.books = bookList.books.sorted {
                    $0.bookFormat < $1.bookFormat
                }
            case .formatDescending:
                viewModel.books = bookList.books.sorted {
                    $0.bookFormat > $1.bookFormat
                }
            case .numberOfPagesAscending:
                viewModel.books = bookList.books.sorted {
                    $0.numberOfPages < $1.numberOfPages
                }
            case .numberOfPagesDescending:
                viewModel.books = bookList.books.sorted {
                    $0.numberOfPages > $1.numberOfPages
                }
            case .numberOfChaptersAscending:
                viewModel.books = bookList.books.sorted {
                    $0.numberOfChapters < $1.numberOfChapters
                }
            case .numberOfChaptersDescending:
                viewModel.books = bookList.books.sorted {
                    $0.numberOfChapters > $1.numberOfChapters
                }
            case .releaseDateAscending:
                viewModel.books = bookList.books.sorted {
                    $0.releaseDate < $1.releaseDate
                }
            case .releaseDateDescending:
                viewModel.books = bookList.books.sorted {
                    $0.releaseDate > $1.releaseDate
                }
            }
        } else {
            switch sortCriteria {
            case .titleAscending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                viewModel.books = filteredBooks.sorted {
                    $0.title < $1.title
                }
            case .titleDescending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                viewModel.books = filteredBooks.sorted {
                    $0.title > $1.title
                }
            case .formatAscending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                viewModel.books = filteredBooks.sorted {
                    $0.bookFormat < $1.bookFormat
                }
            case .formatDescending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                viewModel.books = filteredBooks.sorted {
                    $0.bookFormat > $1.bookFormat
                }
            case .numberOfPagesAscending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                viewModel.books = filteredBooks.sorted {
                    $0.numberOfPages < $1.numberOfPages
                }
            case .numberOfPagesDescending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                viewModel.books = filteredBooks.sorted {
                    $0.numberOfPages > $1.numberOfPages
                }
            case .numberOfChaptersAscending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                                        viewModel.books = filteredBooks.sorted {
                    $0.numberOfChapters < $1.numberOfChapters
                }
            case .numberOfChaptersDescending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                                        viewModel.books = filteredBooks.sorted {
                    $0.numberOfChapters > $1.numberOfChapters
                }
            case .releaseDateAscending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                viewModel.books = filteredBooks.sorted {
                    $0.releaseDate < $1.releaseDate
                }
            case .releaseDateDescending:
                let filteredBooks = bookList.books.filter { $0.title.contains(searchTerm) }
                
                                        viewModel.books = filteredBooks.sorted {
                    $0.releaseDate > $1.releaseDate
                }
            }
        }
                                        
                                        self._viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: viewModel.columns, spacing: 20) {
                ForEach(viewModel.books) { book in
                    BookListBookCell(bookList: bookList, book: book)
                }
            }
        }
        .overlay {
            if viewModel.books.count == 0 && !searchTerm.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            }
            
            if viewModel.books.count == 0 && searchTerm.isEmpty {
                Text("Nothing to Show Right Now. Tap the Add Button to Add a Book to This Book List")
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}
