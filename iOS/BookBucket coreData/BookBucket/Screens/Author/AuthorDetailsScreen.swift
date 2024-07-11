//
//  AuthorDetailsScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI

struct AuthorDetailsScreen: View {
    var author: Author
    
    var body: some View {
        NavigationStack {
            List {
                InfoCell(label: "Author Name", value: "\(author.name)")
                InfoCell(label: "Favorite", value: author.isFavorited ? "Yes" : "No")
                
                NavigationLink(destination: {
                    BooksAuthoredScreen(author: author)
                }, label: {
                    InfoCell(label: "Books Authored", value: "\(author.books.count)")
                })
            }
        }
    }
}
