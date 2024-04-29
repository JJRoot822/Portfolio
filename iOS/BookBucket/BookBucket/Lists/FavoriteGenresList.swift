//
//  FavoriteGenresList.swift
//  BookBucket
//
//  Created by Joshua Root on 4/28/24.
//

import SwiftUI
import SwiftData

struct FavoriteGenresList: View {
    @Query private var genres: [Genre]
    
    var sortCriteria: FavoritesSortCriteria
    var searchTerm: String
    
    init(sortCriteria: FavoritesSortCriteria, searchTerm: String) {
        self.sortCriteria = sortCriteria
        self.searchTerm = searchTerm
        
        if searchTerm.isEmpty {
            switch sortCriteria {
            case .nameAscending:
                self._genres = Query(filter: #Predicate<Genre> { genre in
                    genre.isFavorite
                }, sort: [SortDescriptor(\Genre.name, order: .forward)])
            case .nameDescending:
                self._genres = Query(filter: #Predicate<Genre> { genre in
                    genre.isFavorite
                }, sort: [SortDescriptor(\Genre.name, order: .reverse)])
            }
        } else {
            switch sortCriteria {
            case .nameAscending:
                self._genres = Query(filter: #Predicate<Genre>{ genre in
                    genre.isFavorite && genre.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Genre.name, order: .forward)])
            case .nameDescending:
                self._genres = Query(filter: #Predicate<Genre> { genre in
                    genre.isFavorite && genre.name.contains(searchTerm)
                }, sort: [SortDescriptor(\Genre.name, order: .reverse)])
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
            } else {
                Text("Nothing to show right now. Insert a new genre marked as a favorite on the genres screen, or mark an existing genre as a favorite to get started.")
                    .foregroundStyle(Color.secondary)
            }
        }
    }
}
