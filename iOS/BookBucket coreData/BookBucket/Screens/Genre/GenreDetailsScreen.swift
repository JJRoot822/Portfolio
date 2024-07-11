//
//  GenreDetailsScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/24/24.
//

import SwiftUI

struct GenreDetailsScreen: View {
    var genre: Genre
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("Genre name")
                    
                    Spacer()
                    
                    Text("\(genre.name)")
                }
                
                HStack {
                    Text("Favorite")
                    
                    Spacer()
                    
                    Text(genre.isFavorite ? "Yes" : "No")
                }
                
                NavigationLink(destination: {
                    BooksInGenreScreen(genre: genre)
                }, label: {
                    HStack {
                        Text("Number of Books in Genre")
                        
                        Spacer()
                        
                        Text("\(genre.books.count)")
                    }
                })
            }
        }
    }
}
