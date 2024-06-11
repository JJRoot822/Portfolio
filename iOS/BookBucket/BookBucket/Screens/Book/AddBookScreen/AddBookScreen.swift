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
                        TextField("Title of Book", text: $viewModel.bookTitle)
                        
                        FieldInfoPopoverToggleButton(label: "Show book title field requirements", action: viewModel.toggleRequirementsPopover)
                            .popover(isPresented: $viewModel.isShowingRequirementsPopover) {
                                FieldInfoPopover(infoText: "The book title field must not be empty.")
                            }
                    }
                    
                    BookFormatPicker(selection: $viewModel.bookFormat)
                    
                    DatePicker("Book ReleaseDate", selection: $viewModel.bookReleaseDate, displayedComponents: .date)
                    
                    BookCoverImagePicker(selection: $viewModel.bookCoverImageData)
                    
                    TextField("Number of Pages", value: $viewModel.numberOfPages, formatter: integerFormatter)

                    TextField("Number of Chapters", value: $viewModel.numberOfChapters, formatter: integerFormatter)
                    
                    Toggle("Is Favorite Book", isOn: $viewModel.isFavoriteBook)
                }
                
                Section {
                    Toggle("Is Currently Reading", isOn: $viewModel.isCurrentlyReadingBook)
                    Toggle("Completed", isOn: $viewModel.hasCompletedBook)
                    TextField("Number of Pages Read", value: $viewModel.numberOfPagesRead, formatter: integerFormatter)
                        .disabled(!viewModel.isCurrentlyReadingBook || viewModel.hasCompletedBook)
                    
                    TextField("Number of Chapters Read", value: $viewModel.numberOfChaptersRead, formatter: integerFormatter)
                        .disabled(!viewModel.isCurrentlyReadingBook || viewModel.hasCompletedBook)
                }
            }
            .navigationTitle(Text("Add Book"))
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(title: Text("Failed to Create Book"), message: Text("Something went wrong when trying to save the data you entered for a new book. Please try again later."))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: viewModel.cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        viewModel.create(context: context)
                    }
                    .disabled(viewModel.bookTitle.isEmpty || viewModel.numberOfPages == 0 || viewModel.numberOfChapters == 0)
                }
            }
        }
        .onChange(of: viewModel.shouldDismiss) {
            if viewModel.shouldDismiss {
                dismiss()
            }
        }
        .onChange(of: viewModel.hasCompletedBook) {
            if viewModel.hasCompletedBook {
                viewModel.numberOfPagesRead = viewModel.numberOfPages
                viewModel.numberOfChaptersRead = viewModel.numberOfChapters
            } else {
                viewModel.numberOfPagesRead = 0
                viewModel.numberOfChaptersRead = 0
            }
        }
    }
}
