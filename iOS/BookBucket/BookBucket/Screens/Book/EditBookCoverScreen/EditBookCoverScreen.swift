//
//  EditBookCoverScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/8/24.
//

import SwiftUI
import SwiftData

struct EditBookCoverScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @Bindable var book: Book
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                if let imageData = book.coverImage, let coverImage = UIImage(data: imageData) {
                    Image(uiImage: coverImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                } else {
                    ZStack {
                        Rectangle()
                            .frame(width: 200, height: 300)
                    
                        Text("No cover image for this book was selected.")
                    }
                }
                
                BookCoverImagePicker(selection: $book.coverImage)
            }
            .navigationTitle(Text("Change Book Cover"))
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to this book. Please try again later."))
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
        .onChange(of: viewModel.shouldDismiss) {
            if viewModel.shouldDismiss {
                dismiss()
            }
        }
    }
}
