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
                HStack {
                    Text("Author name")
                    
                    Spacer()
                    
                    Text("\(author.name)")
                }
                
                HStack {
                    Text("Favorite")
                    
                    Spacer()
                    
                    Text(author.isFavorited ? "Yes" : "No")
                }
                
                NavigationLink(destination: {
                    BooksAuthoredScreen(author: author)
                }, label: {
                    HStack {
                        Text("Number of Books Authored")
                        
                        Spacer()
                        
                        Text("\(author.books.count)")
                    }
                })
            }
        }
    }
}
