//
//  BooksInGenreScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/24/24.
//

import SwiftUI

struct BooksInGenreScreen: View {
    var genre: Genre
    
    var body: some View {
        NavigationStack {
            if genre.books.isEmpty {
                Text("Nothing to show right now. Add a genre to this book to see it here.")
                    .foregroundStyle(Color.secondary)
                    .navigationTitle(Text("Genres"))
            } else {
                List {
                    ForEach(genre.books) { book in
                        Text(book.title)
                            .padding()
                    }
                }
                .navigationTitle(Text("Genres"))
            }
        }
    }
}
