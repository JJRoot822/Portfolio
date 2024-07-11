//
//  BooksAuthoredScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI

struct BooksAuthoredScreen: View {
    var author: Author
    
    var body: some View {
        NavigationStack {
            if author.books.isEmpty {
                Text("Nothing to show right now. Add this author to a book to see it here")
                    .foregroundStyle(Color.secondary)
                    .navigationTitle(Text("Books Authored"))
            } else {
                List {
                    ForEach(author.books) { book in
                        Text(book.title)
                            .padding()
                    }
                }
                .navigationTitle(Text("Books Authored"))
            }
        }
    }
}
