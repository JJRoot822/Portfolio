//
//  FavoriteBooksList.swift
//  BookBucket
//
//  Created by Joshua Root on 5/14/24.
//

import SwiftUI
import SwiftData

struct FavoriteBooksList: View {
    @Query private var books: [Book]
    
    var sortCriteria: FavoritesSortCriteria
    var searchTerm: String
    
    init(sortCriteria: FavoritesSortCriteria, searchTerm: String) {
        self.sortCriteria = sortCriteria
        self.searchTerm = searchTerm
        
        if searchTerm.isEmpty {
            switch sortCriteria {
            case .nameAscending:
                self._books = Query(filter: #Predicate<Book> { book in
                    book.isFavorite
                }, sort: [SortDescriptor(\Book.title, order: .forward)])
            case .nameDescending:
                self._books = Query(filter: #Predicate<Book> { book in
                    book.isFavorite
                }, sort: [SortDescriptor(\Book.title, order: .reverse)])
            }
        } else {
            switch sortCriteria {
            case .nameAscending:
                self._books = Query(filter: #Predicate<Book>{ book in
                    book.isFavorite && book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.title, order: .forward)])
            case .nameDescending:
                self._books = Query(filter: #Predicate<Book> { book in
                    book.isFavorite && book.title.contains(searchTerm)
                }, sort: [SortDescriptor(\Book.title, order: .reverse)])
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(books) { book in
//                FavoriteBookCell(bookList: bookList)
            }
        }
        .overlay {
            if books.count == 0 && !searchTerm.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            }
            
            if books.count == 0 && searchTerm.isEmpty {
                Text("Nothing to show right now. Insert a new book marked as a favorite on the books screen, or mark an existing book as a favorite to get started.")
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}
