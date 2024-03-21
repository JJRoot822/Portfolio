//
//  EditBookScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 3/21/24.
//

import SwiftUI
import SwiftData

struct EditBookScreen: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var book: Book
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Book Title", text: $book.title)
                    BookFormatPicker(selection: $book.bookFormat)
                    DatePicker("Release Date", selection: $book.releaseDate, displayedComponents: .date)
                    Stepper(label: {
                        Text("\(book.numberOfChapters) Chapters")
                    }, onIncrement: incrementChapters, onDecrement: decrementChapters)
                    
                    Stepper(label: {
                        Text("\(book.numberOfPages) Pages")
                    }, onIncrement: incrementPages, onDecrement: decrementPages)
                    
                    BookCoverImagePicker(selection: $book.coverImage)
                }
                
                Section {
                    Toggle("Is Favorite Book", isOn: $book.isFavorite)
                }
                
                Section {
                    Toggle("Completed", isOn: $book.isCompleted)
                    Toggle("Currently Reading", isOn: $book.isReading)
                    
                    Stepper(label: {
                        Text("\(book.numberOfPagesRead) Pages Read")
                    }, onIncrement: incrementPagesRead, onDecrement: decrementPagesRead)
                    .disabled(!book.isReading)
                    
                    Stepper(label: {
                        Text("\(book.numberOfChaptersRead) Chapters Read")
                    }, onIncrement: incrementChaptersRead, onDecrement: decrementChaptersRead)
                    .disabled(!book.isReading)
                }
                
                Button("Save", action: save)
                Button("Delete Book", action: deleteBook)
                Button("Cancel", role: .cancel, action: cancelEditBook)
            }
            .navigationTitle(Text("Edit Book"))
            .navigationBarTitleDisplayMode(.large)
        }
        .interactiveDismissDisabled()
    }

    private func incrementPages() {
        book.numberOfPages += 1
    }
    
    private func incrementChapters() {
        book.numberOfChapters += 1
    }
    
    private func incrementPagesRead() {
        book.numberOfPagesRead += 1
    }
    
    private func incrementChaptersRead() {
        book.numberOfChaptersRead += 1
    }
    
    private func decrementPages() {
        book.numberOfPages -= 1
    }
    
    private func decrementChapters() {
        book.numberOfChapters -= 1
    }
    
    private func decrementPagesRead() {
        book.numberOfPagesRead -= 1
    }
    
    private func decrementChaptersRead() {
        book.numberOfChaptersRead -= 1
    }
    
    private func cancelEditBook() {
        modelContext.rollback()
        dismiss()
    }
    
    private func deleteBook() {
        modelContext.delete(book)
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
