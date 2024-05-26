//
//  BookDetailsScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI

struct BookDetailsScreen: View {
    var book: Book
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        return formatter
    }()

    @State private var showAddAuthorsToBook = false
    @State private var showAddGenresToBook = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let data = book.coverImage,
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }
                
                Form {
                    HStack {
                        Text("Book Title")
                        
                        Spacer()
                        
                        Text("\(book.title)")
                    }
                    
                    HStack {
                        Text("Format")
                        
                        Spacer()
                        
                        Text("\(book.bookFormat)")
                    }
                    
                    HStack {
                        Text("Currently Reading")
                        
                        Spacer()
                        
                        Text(book.isReading ? "Yes" : "No")
                    }
                    
                    HStack {
                        Text("Completed)")
                        
                        Spacer()
                        
                        Text(book.isCompleted ? "Yes" : "No")
                    }
                    
                    HStack {
                        Text("Favorite")
                        
                        Spacer()
                        
                        Text(book.isFavorite ? "Yes" : "No")
                    }
                    
                    HStack {
                        Text("Number of Pages")
                        
                        Spacer()
                        
                        Text("\(book.numberOfPages)")
                    }
                    
                    HStack {
                        Text("Number of Chapters")
                        
                        Spacer()
                        
                        Text("\(book.numberOfChapters)")
                    }
                    
                    HStack {
                        Text("Number of Pages Read")
                        
                        Spacer()
                        
                        Text("\(book.numberOfPagesRead)")
                    }
                    
                    HStack {
                        Text("Number of Chapters Read")
                        
                        Spacer()
                        
                        Text("\(book.numberOfChaptersRead)")
                    }
                    
                    HStack {
                        Text("Release Date")
                        
                        Spacer()
                        
                        Text(book.releaseDate, formatter: dateFormatter)
                    }
                    
                    HStack {
                        NavigationLink(destination: {
                            BookAuthorsScreen(authors: book.authors)
                        }, label: {
                            HStack {
                                Text("Number of Authors")
                                
                                Spacer()
                                
                                Text("\(book.authors.count)")
                            }
                        })
                        
                        NavigationLink(destination: {
                            BookGenresScreen(genres: book.genres)
                        }, label: {
                            HStack {
                                Text("Number of Genres")
                                
                                Spacer()
                                
                                Text("\(book.genres.count)")
                            }
                        })
                    }
                }
                .toolbar {
                    Menu(content: {
                        Button("Add Authors", action: showAddAuthorsToBookScreen)
                        Button("Add Genres", action: showAddGenresToBookScreen)
                    }, label: {
                        Label("Options", systemImage: "plus")
                    })
                }
            }
            .sheet(isPresented: $showAddAuthorsToBook) {
                AddAuthorsToBookScreen(book: book)
            }
            .sheet(isPresented: $showAddGenresToBook) {
                AddGenresToBookScreen(book: book)
            }
        }
    }
    
    private func showAddAuthorsToBookScreen() {
        self.showAddAuthorsToBook = true
    }
    
    private func showAddGenresToBookScreen() {
        self.showAddGenresToBook = true
    }
}
