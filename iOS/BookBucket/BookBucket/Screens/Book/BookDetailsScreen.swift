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
    @State private var id: UUID = UUID()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let data = book.coverImage,
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .accessibilityHidden(true)
                }
                
                Form {
                    InfoCell(label: "Book Title", value: "\(book.title)")
                    InfoCell(label: "Format", value: "\(book.bookFormat)")
                    InfoCell(label: "Currently Reading", value: book.isReading ? "Yes" : "No")
                    InfoCell(label: "Completed", value: book.isCompleted ? "Yes" : "No")
                    InfoCell(label: "Favorite", value: book.isFavorite ? "Yes" : "No")
                    InfoCell(label: "Number of Pages", value: "\(book.numberOfPages)")
                    InfoCell(label: "Number of Chapters", value: "\(book.numberOfChapters)")
                    InfoCell(label: "Number of Pages Read", value: "\(book.numberOfPagesRead)")
                    InfoCell(label: "Number of Chapters Read", value: "\(book.numberOfChaptersRead)")
                InfoCell(label: "Release Date", value: dateFormatter.string(from: book.releaseDate))
                    
                    NavigationLink(destination: {
                        BookAuthorsScreen(authors: book.authors)
                    }, label: {
                        InfoCell(label: "Number of Authors", value: "\(book.authors.count)")
                    })
                    
                    NavigationLink(destination: {
                        BookGenresScreen(genres: book.genres)
                    }, label: {
                        InfoCell(label: "Number of Genres", value: "\(book.genres.count)")
                    })
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
            .sheet(isPresented: $showAddAuthorsToBook, onDismiss: {
                id = UUID()
            }) {
                AddAuthorsToBookScreen(book: book)
            }
            .sheet(isPresented: $showAddGenresToBook, onDismiss: {
                id = UUID()
            }) {
                AddGenresToBookScreen(book: book)
            }
        }
        .id(id)
    }
    
    private func showAddAuthorsToBookScreen() {
        self.showAddAuthorsToBook = true
    }
    
    private func showAddGenresToBookScreen() {
        self.showAddGenresToBook = true
    }
}
