//
//  AddBookScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/1/24.
//

import SwiftUI
import SwiftData

struct AddBookScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var bookTitle: String = ""
    @State private var bookFormat: String = "Print"
    @State private var bookReleaseDate: Date = Date()
    @State private var bookCoverImageData: Data? = nil
    @State private var isFavoriteBook: Bool = false
    @State private var numberOfPages: Int = 0
    @State private var numberOfChapters: Int = 0
    @State private var numberOfPagesRead: Int = 0
    @State private var numberOfChaptersRead: Int = 0
    @State private var isCurrentlyReadingBook = false
    @State private var hasCompletedBook: Bool = false
    
    @State private var isShowingError: Bool = false
    @State private var isShowingRequirementsPopover: Bool = false

    var integerFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Information") {
                    HStack(spacing: 10) {
                        TextField("Title of Book", text: $bookTitle)
                        
                        FieldInfoPopoverToggleButton(label: "Show book title field requirements", action: toggleRequirementsPopover)
                            .popover(isPresented: $isShowingRequirementsPopover) {
                                FieldInfoPopover(infoText: "The book title field must not be empty.")
                            }
                    }
                    
                    BookFormatPicker(selection: $bookFormat)
                    
                    DatePicker("Book ReleaseDate", selection: $bookReleaseDate, displayedComponents: .date)
                    
                    BookCoverImagePicker(selection: $bookCoverImageData)
                    
                    TextField("Number of Pages", value: $numberOfPages, formatter: integerFormatter)
                    TextField("Number of Chapters", value: $numberOfChapters, formatter: integerFormatter)
                    
                    Toggle("Is Favorite Book", isOn: $isFavoriteBook)
                }
                
                Section("Reading Status Information") {
                    Toggle("Is Currently Reading", isOn: $isCurrentlyReadingBook)
                    Toggle("Has Completed Book", isOn: $hasCompletedBook)
                        
                    TextField("Number of Pages Read", value: $numberOfPagesRead, formatter: integerFormatter)
                        .disabled(!isCurrentlyReadingBook || hasCompletedBook)
                    
                    TextField("Number of Chapters Read", value: $numberOfChaptersRead, formatter: integerFormatter).disabled(!isCurrentlyReadingBook || hasCompletedBook)
                }
            }
            .navigationTitle(Text("Add Book"))
            .alert(isPresented: $isShowingError) {
                Alert(title: Text("Failed to Create Book"), message: Text("Something went wrong when trying to save the data you entered for a new book. Please try again later."))
            }
            .onChange(of: hasCompletedBook) {
                if hasCompletedBook {
                    numberOfPagesRead = numberOfPages
                    numberOfChaptersRead = numberOfChapters
                } else {
                    numberOfPagesRead = 0
                    numberOfChaptersRead = 0
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create", action: create)
                        .disabled(bookTitle.isEmpty || numberOfPages == 0 || numberOfChapters == 0)
                }
            }
        }
    }
    
    private func incrementPages() {
        numberOfPages += 1
    }
    
    private func incrementChapters() {
        numberOfChapters += 1
    }
    
    private func incrementPagesRead() {
        if numberOfPagesRead < numberOfPages {
            numberOfPagesRead += 1
        }
    }
    
    private func incrementChaptersRead() {
        if numberOfChaptersRead < numberOfChapters {
            numberOfChaptersRead += 1
        }
    }
    
    private func decrementPages() {
        if numberOfPages > 0 {
            numberOfPages -= 1
        }
    }
    
    private func decrementChapters() {
        if numberOfChapters > 0 {
            numberOfChapters -= 1
        }
    }
    
    private func decrementPagesRead() {
        if numberOfPagesRead > 0 {
            numberOfPagesRead -= 1
        }
    }
    
    private func decrementChaptersRead() {
        if numberOfChaptersRead > 0 {
            numberOfChaptersRead -= 1
        }
    }
    
    private func toggleRequirementsPopover() {
        isShowingRequirementsPopover.toggle()
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func create() {
        let book = Book(title: bookTitle, isFavorite: isFavoriteBook, bookFormat: bookFormat, releaseDate: bookReleaseDate, numberOfPages: numberOfPages, numberOfChapters: numberOfChapters, numberOfChaptersRead: numberOfChaptersRead, numberOfPagesRead: numberOfPagesRead, isReading: isCurrentlyReadingBook, isCompleted: hasCompletedBook, coverImage: bookCoverImageData, bookLists: [], authors: [], genres: [])
        let dataHelper = DataHelper()
        let result = dataHelper.insert(context: context, model: book)
        
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
