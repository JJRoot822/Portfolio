//
//  AddBookScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 3/19/24.
//

import SwiftUI
import SwiftData

struct AddBookScreen: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var bookFormat: String = "print"
    @State private var releaseDate: Date = Date()
    @State private var numberOfChapters: Int = 0
    @State private var numberOfPages: Int = 0
    @State private var coverImage: Data? = nil
    
    @State private var isFavorite: Bool = false
    
    @State private var numberOfChaptersRead: Int = 0
    @State private var numberOfPagesRead: Int = 0
    @State private var isReading: Bool = false
    @State private var isCompleted: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Book Title", text: $title)
                    BookFormatPicker(selection: $bookFormat)
                    DatePicker("Release Date", selection: $releaseDate, displayedComponents: .date)
                    Stepper(label: {
                        Text("\(numberOfChapters) Chapters")
                    }, onIncrement: incrementChapters, onDecrement: decrementChapters)
                    
                    Stepper(label: {
                        Text("\(numberOfPages) Pages")
                    }, onIncrement: incrementPages, onDecrement: decrementPages)
                    
                    BookCoverImagePicker(selection: $coverImage)
                }
                
                Section {
                    Toggle("Is Favorite Book", isOn: $isFavorite)
                }
                
                Section {
                    Toggle("Completed", isOn: $isCompleted)
                    Toggle("Currently Reading", isOn: $isReading)
                    
                    Stepper(label: {
                        Text("\(numberOfPagesRead) Pages Read")
                    }, onIncrement: incrementPagesRead, onDecrement: decrementPagesRead)
                    .disabled(!isReading)
                    
                    Stepper(label: {
                        Text("\(numberOfChaptersRead) Chapters Read")
                    }, onIncrement: incrementChaptersRead, onDecrement: decrementChaptersRead)
                    .disabled(!isReading)
                }
                
                Button("Cancel", role: .cancel, action: cancelAddBook)
                Button("Add Book", action: addBook)
            }
            .navigationTitle(Text("Add New Book"))
            .navigationBarTitleDisplayMode(.large)
        }
        .interactiveDismissDisabled()
    }

    private func incrementPages() {
        numberOfPages += 1
    }
    
    private func incrementChapters() {
        numberOfChapters += 1
    }
    
    private func incrementPagesRead() {
        numberOfPagesRead += 1
    }
    
    private func incrementChaptersRead() {
        numberOfChaptersRead += 1
    }
    
    private func decrementPages() {
        numberOfPages -= 1
    }
    
    private func decrementChapters() {
        numberOfChapters -= 1
    }
    
    private func decrementPagesRead() {
        numberOfPagesRead -= 1
    }
    
    private func decrementChaptersRead() {
        numberOfChaptersRead -= 1
    }
    
    private func cancelAddBook() {
        dismiss()
    }
    
    private func addBook() {
        let book = Book(title: title, isFavorite: isFavorite, bookFormat: bookFormat, releaseDate: releaseDate, numberOfPages: numberOfPages, numberOfChapters: numberOfChapters, numberOfChaptersRead: numberOfChaptersRead, numberOfPagesRead: numberOfPagesRead, isReading: isReading, isCompleted: isCompleted, coverImage: coverImage, bookLists: [], authors: [], genres: [])
        modelContext.insert(book)
        
        save()
    }
    
    private func save() {
        do {
            try modelContext.save()
            
            dismiss()
        } catch {
            fatalError("Failed to save")
        }
    }
}
