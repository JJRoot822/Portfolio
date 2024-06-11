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

    @State private var viewModel = ViewModel()
    
    let integerFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        
        return formatter
    }()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 10) {
                        TextField("Title of Book", text: $book.title)
                        
                        FieldInfoPopoverToggleButton(label: "Show book title field requirements", action: viewModel.toggleRequirementsPopover)
                            .popover(isPresented: $viewModel.isShowingRequirementsPopover) {
                            FieldInfoPopover(infoText: "The book title field must not be empty.")
                        }
                    }
                    
                    BookFormatPicker(selection: $book.bookFormat)
                    
                    DatePicker("Book ReleaseDate", selection: $book.releaseDate, displayedComponents: .date)
                    
                    TextField("Number of Pages", value: $book.numberOfPages, formatter: integerFormatter)
                    TextField("Number of Chapters", value: $book.numberOfChapters, formatter: integerFormatter)
                    
                    Toggle("Is Favorite Book", isOn: $book.isFavorite)
                }
                
                Section {
                    Toggle("Is Currently Reading", isOn: $book.isReading)
                    Toggle("Has Completed Book", isOn: $book.isCompleted)
                        
                    TextField("Number of Pages Read", value: $book.numberOfPagesRead, formatter: integerFormatter)
                        .disabled(!book.isReading || book.isCompleted)
                    
                    TextField("Number of Chapters Read", value: $book.numberOfChaptersRead, formatter: integerFormatter).disabled(!book.isReading || book.isCompleted)
                }
            }
            .onChange(of: viewModel.shouldDismiss) {
                if viewModel.shouldDismiss {
                    dismiss()
                }
            }
            .navigationTitle(Text("Add Book"))
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to this book. Please try again later."))
            }
            .onChange(of: book.isCompleted) {
                if book.isCompleted {
                    book.numberOfPagesRead = book.numberOfPages
                    book.numberOfChaptersRead = book.numberOfChapters
                } else {
                    book.numberOfPagesRead = 0
                    book.numberOfChaptersRead = 0
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        viewModel.cancel(context: context)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveChanges(context: context)
                    }
                        .disabled(book.title.isEmpty || book.numberOfPages == 0 || book.numberOfChapters == 0)
                }
            }
        }
    }
}