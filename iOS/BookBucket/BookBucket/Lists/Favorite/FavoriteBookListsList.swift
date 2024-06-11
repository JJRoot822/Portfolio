//
//  FavoriteBookListsList.swift
//  BookBucket
//
//  Created by Joshua Root on 4/28/24.
//

import SwiftUI
import SwiftData

struct FavoriteBookListsList: View {
    @Query private var bookLists: [BookList]
    
    var sortCriteria: FavoritesSortCriteria
    var searchTerm: String
    
    init(sortCriteria: FavoritesSortCriteria, searchTerm: String) {
        self.sortCriteria = sortCriteria
        self.searchTerm = searchTerm
        
        if searchTerm.isEmpty {
            switch sortCriteria {
            case .nameAscending:
                self._bookLists = Query(filter: #Predicate<BookList> { bookList in
                    bookList.isFavorite
                }, sort: [SortDescriptor(\BookList..title, order: .forward)])
            case .nameDescending:
                self._bookLists = Query(filter: #Predicate<BookList> { bookList in
                    bookList.isFavorite
                }, sort: [SortDescriptor(\BookList.title, order: .reverse)])
            }
        } else {
            switch sortCriteria {
            case .nameAscending:
                self._bookLists = Query(filter: #Predicate<BookList>{ bookList in
                    bookList.isFavorite && bookList.title.contains(searchTerm)
                }, sort: [SortDescriptor(\BookList.title, order: .forward)])
            case .nameDescending:
                self._bookLists = Query(filter: #Predicate<BookList> { bookList in
                    bookList.isFavorite && bookList.title.contains(searchTerm)
                }, sort: [SortDescriptor(\BookList.title, order: .reverse)])
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
            } 
            
            if bookLists.count == 0 && searchTerm.isEmpty {
                Text("Nothing to show right now. Insert a new book list marked as a favorite on the book lists screen, or mark an existing book list as a favorite to get started.")
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}
