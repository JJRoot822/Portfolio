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
            List {
                ForEach(author.books) { book in
                    Text(book.title)
                        .padding()
                }
            }
        }
    }
}
