//
//  GlobalState.swift
//  BookBucket
//
//  Created by Joshua Root on 3/31/24.
//

import SwiftUI

class GlobalState: ObservableObject {
    @Published var showingAddAuthor: Bool = false
    @Published var showingAddBook: Bool = false
    @Published var showingAddBookList: Bool = false
    @Published var showingAddGenre: Bool = false
    @Published var authorSortCriteria: AuthorSortCriteria = .nameAscending
    @Published var genreSortCriteria: GenreSortCriteria = .nameAscending
    @Published var bookSortCriteria: BookSortCriteria = .titleAscending
    @Published var bookListSortCriteria: BookListSortCriteria = .nameAscending
}
