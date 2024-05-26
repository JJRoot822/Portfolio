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
            List {
                ForEach(genre.books) { book in
                    Text(book.title)
                        .padding()
                }
            }
            .navigationTitle(Text("Books in \(genre.name)"))
        }
    }
}
