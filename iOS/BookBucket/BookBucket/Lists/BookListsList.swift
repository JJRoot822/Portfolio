//
//  BookListsList.swift
//  BookBucket
//
//  Created by Joshua Root on 4/30/24.
//

import SwiftUI
import SwiftData

struct BookListsList: View {
    @Query private var bookLists: [BookList]
    
    var sortCriteria: BookListSortCriteria
    var searchTerm: String
    
    init(sortCriteria: BookListSortCriteria, searchTerm: String) {
        self.sortCriteria = sortCriteria
        self.searchTerm = searchTerm
        
        if searchTerm.isEmpty {
            switch sortCriteria {
            case .nameAscending:
                self._bookLists = Query(sort: \BookList.title)
            case .nameDescending:
                self._bookLists = Query(sort: \BookList.title, order: .reverse)
            case .numberOfBooksAscending:
                self._bookLists = Query(sort: \BookList.books.count)
            case .numberOfBooksDescending:
                self._bookLists = Query(sort: \BookList.books.count, order: .reverse)
            }
        } else {
            switch sortCriteria {
            case .nameAscending:
                self._bookLists = Query(filter: #Predicate<BookList>{ bookList in
                    bookList.title.contains(searchTerm)
                }, sort: [SortDescriptor(\BookList.title, order: .forward)])
            case .nameDescending:
                self._bookLists = Query(filter: #Predicate<BookList> { bookList in
                    bookList.title.contains(searchTerm)
                }, sort: [SortDescriptor(\BookList.title, order: .reverse)])
            case .numberOfBooksAscending:
                self._bookLists = Query(filter: #Predicate<BookList> { bookList in
                    bookList.title.contains(searchTerm)
                }, sort: [SortDescriptor(\BookList.books.count, order: .forward)])
            case .numberOfBooksDescending:
                self._bookLists = Query(filter: #Predicate<BookList> { bookList in
                    bookList.title.contains(searchTerm)
                }, sort: [SortDescriptor(\BookList.books.count, order: .reverse)])
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(bookLists) { bookList in
                BookListCell(bookList: bookList)
            }
        }
        .overlay {
            if bookLists.count == 0 && !searchTerm.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            } else {
                Text("Nothing to show right now. Tap the add button to insert a new book list.")
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}
