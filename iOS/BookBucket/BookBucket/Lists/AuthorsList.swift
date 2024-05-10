//
//  AuthorsList.swift
//  BookBucket
//
//  Created by Joshua Root on 4/24/24.
//

import SwiftUI
import SwiftData

struct AuthorsList: View {
    @Query private var authors: [Author]
    
    var sortCriteria: AuthorSortCriteria
    var searchTerm: String
    
    init(sortCriteria: AuthorSortCriteria, searchTerm: String) {
        self.sortCriteria = sortCriteria
        self.searchTerm = searchTerm
        
        if searchTerm.isEmpty {
            switch sortCriteria {
            case .nameAscending:
                self._authors = Query(sort: \Author.name)
            case .nameDescending:
                self._authors = Query(sort: \Author.name, order: .reverse)
            case .booksAuthoredAscending:
                self._authors = Query(sort: \Author.books.count)
            case .booksAuthoredDescending:
                self._authors = Query(sort: \Author.books.count, order: .reverse)
            }
        } else {
            switch sortCriteria {
            case .nameAscending:
                self._authors = Query(filter: #Predicate<Author>{ author in
                    author.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Author.name, order: .forward)])
            case .nameDescending:
                self._authors = Query(filter: #Predicate<Author> { author in
                    author.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Author.name, order: .reverse)])
            case .booksAuthoredAscending:
                self._authors = Query(filter: #Predicate<Author> { author in
                    author.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Author.books.count, order: .forward)])
            case .booksAuthoredDescending:
                self._authors = Query(filter: #Predicate<Author> { author in
                    author.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Author.books.count, order: .reverse)])
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(authors) { author in
                AuthorCell(author: author)
            }
        }
        .overlay {
            if authors.count == 0 && !searchTerm.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            }
            
            if authors.count == 0 && searchTerm.isEmpty {
                Text("Nothing to Show Right Now. Tap the Add Button to Insert a New Author")
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}
