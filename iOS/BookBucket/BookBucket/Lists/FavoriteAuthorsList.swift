//
//  FavoriteAuthorsList.swift
//  BookBucket
//
//  Created by Joshua Root on 4/28/24.
//

import SwiftUI
import SwiftData

struct FavoriteAuthorsList: View {
    @Query private var authors: [Author]
    
    var sortCriteria: FavoritesSortCriteria
    var searchTerm: String
    
    init(sortCriteria: FavoritesSortCriteria, searchTerm: String) {
        self.sortCriteria = sortCriteria
        self.searchTerm = searchTerm
        
        if searchTerm.isEmpty {
            switch sortCriteria {
            case .nameAscending:
                self._authors = Query(filter: #Predicate<Author> { author in
                    author.isFavorited
                }, sort: [SortDescriptor(\Author.name, order: .forward)])
            case .nameDescending:
                self._authors = Query(filter: #Predicate<Author> { author in
                    author.isFavorited
                }, sort: [SortDescriptor(\Author.name, order: .reverse)])
            }
        } else {
            switch sortCriteria {
            case .nameAscending:
                self._authors = Query(filter: #Predicate<Author>{ author in
                    author.isFavorited && author.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Author.name, order: .forward)])
            case .nameDescending:
                self._authors = Query(filter: #Predicate<Author> { author in
                    author.isFavorited && author.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Author.name, order: .reverse)])
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
            } else {
                Text("Nothing to show right now. Insert a new author marked as a favorite on the authors screen, or mark an existing author as a favorite to get started.")
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}
