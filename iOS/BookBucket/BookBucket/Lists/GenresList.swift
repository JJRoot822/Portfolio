//
//  GenresList.swift
//  BookBucket
//
//  Created by Joshua Root on 4/25/24.
//

import SwiftUI
import SwiftData

struct GenresList: View {
    @Query private var genres: [Genre]
    
    var sortCriteria: GenreSortCriteria
    var searchTerm: String
    
    init(sortCriteria: GenreSortCriteria, searchTerm: String) {
        self.sortCriteria = sortCriteria
        self.searchTerm = searchTerm
        
        if searchTerm.isEmpty {
            switch sortCriteria {
            case .nameAscending:
                self._genres = Query(sort: \Genre.name)
            case .nameDescending:
                self._genres = Query(sort: \Genre.name, order: .reverse)
            case .numberOfBooksAscending:
                self._genres = Query(sort: \Genre.books.count)
            case .numberOfBooksDescending:
                self._genres = Query(sort: \Genre.books.count, order: .reverse)
            }
        } else {
            switch sortCriteria {
            case .nameAscending:
                self._genres = Query(filter: #Predicate<Genre>{ genre in
                    genre.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Genre.name, order: .forward)])
            case .nameDescending:
                self._genres = Query(filter: #Predicate<Genre> { genre in
                    genre.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Genre.name, order: .reverse)])
            case .numberOfBooksAscending:
                self._genres = Query(filter: #Predicate<Genre> { genre in
                    genre.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Genre.books.count, order: .forward)])
            case .numberOfBooksDescending:
                self._genres = Query(filter: #Predicate<Genre> { genre in
                    genre.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Genre.books.count, order: .reverse)])
            }
        }
    }
    
    var body: some View {
        List {
            ForEach(genres) { genre in
                GenreCell(genre: genre)
            }
        }
        .overlay {
            if genres.count == 0 && !searchTerm.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            }
        }
    }
}
