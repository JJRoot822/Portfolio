//
//  EditBookScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/8/24.
//

import SwiftUI
import SwiftData

struct EditBookScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @Bindable var book: Book
    
    @State private var isShowingError: Bool = false
    @State private var isShowingRequirementsPopover: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Information") {
                    HStack(spacing: 10) {
                        TextField("Title of Book", text: $book.title)
                        
                        Button(action: toggleRequirementsPopover) {
                            Label("Show book title field requirements", systemImage: "info.circle")
                        }
                        .popover(isPresented: $isShowingRequirementsPopover) {
                            VStack {
                                Text("The book title field must not be empty.")
                                
                                HStack {
                                    Spacer()
                                    
                                    Button("Close", action: toggleRequirementsPopover)
                                }
                            }
                            .padding()
                        }
                    }
                    
                    BookFormatPicker(selection: $book.bookFormat)
                    
                    DatePicker("Book ReleaseDate", selection: $book.releaseDate, displayedComponents: .date)
                    
                    Stepper(label: {
                        Text("Pages: \(book.numberOfPages)")
                    }, onIncrement: incrementPages, onDecrement: decrementPages)
                    
                    Stepper(label: {
                        Text("Chapters: \(book.numberOfChapters)")
                    }, onIncrement: incrementChapters, onDecrement: decrementChapters)
                    
                    Toggle("Is Favorite Book", isOn: $book.isFavorite)
                }
                
                Section("Reading Status Information") {
                    Toggle("Is Currently Reading", isOn: $book.isReading)
                    Toggle("Has Completed Book", isOn: $book.isCompleted)
                    
                    Stepper(label: {
                        Text("Pages Read: \(book.numberOfPagesRead)")
                    }, onIncrement: incrementPagesRead, onDecrement: decrementPagesRead)
                    .disabled(!book.isReading || book.isCompleted)
                    
                    Stepper(label: {
                        Text("Chapters Read: \(book.numberOfChaptersRead)")
                    }, onIncrement: incrementChaptersRead, onDecrement: decrementChaptersRead)
                    .disabled(!book.isReading || book.isCompleted)
                }
            }
            .navigationTitle(Text("Add Book"))
            .alert(isPresented: $isShowingError) {
                Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to this book. Please try again later."))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: saveChanges)
                        .disabled(book.title.isEmpty || book.numberOfPages == 0 || book.numberOfChapters == 0)
                }
            }
        }
    }
    
    private func incrementPages() {
        book.numberOfPages += 1
    }
    
    private func incrementChapters() {
        book.numberOfChapters += 1
    }
    
    private func incrementPagesRead() {
        if book.numberOfPagesRead < book.numberOfPages {
            book.numberOfPagesRead += 1
        }
    }
    
    private func incrementChaptersRead() {
        if book.numberOfChaptersRead < book.numberOfChapters {
            book.numberOfChaptersRead += 1
        }
    }
    
    private func decrementPages() {
        if book.numberOfPages > 0 {
            book.numberOfPages -= 1
        }
    }
    
    private func decrementChapters() {
        if book.numberOfChapters > 0 {
            book.numberOfChapters -= 1
        }
    }
    
    private func decrementPagesRead() {
        if book.numberOfPagesRead > 0 {
            book.numberOfPagesRead -= 1
        }
    }
    
    private func decrementChaptersRead() {
        if book.numberOfChaptersRead > 0 {
            book.numberOfChaptersRead -= 1
        }
    }
    
    private func toggleRequirementsPopover() {
        isShowingRequirementsPopover.toggle()
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func saveChanges() {
        let dataHelper = DataHelper()
        let result = dataHelper.save(context: context)
        
        switch result {
        case .success(()):
            dismiss()
            return
        case .failure(_):
            if context.hasChanges {
                context.rollback()
            }
            
            isShowingError = true
        }
    }
}
