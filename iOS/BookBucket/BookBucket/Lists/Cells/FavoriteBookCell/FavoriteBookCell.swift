//
//  FavoriteBookCell.swift
//  BookBucket
//
//  Created by Joshua Root on 4/28/24.
//

import SwiftUI
import SwiftData

struct FavoriteBookCell: View {
    @Environment(\.modelContext) var context
    
    @State private var viewModel = ViewModel()
    
    @Bindable var book: Book
    
    var body: some View {
        NavigationLink(destination: {
            BookDetailsScreen(book: book)
        }, label: {
            HStack(spacing: 20) {
                viewModel.getBookCoverImage(book: book)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .accessibilityHidden(true)
                
                VStack(alignment: .leading) {
                    Text(book.title)
                    
                    Text("Authors: \(book.authors.count)")
                        .foregroundStyle(Color.secondary)
                    
                    ProgressView(value: viewModel.getReadingProgress(book: book))
                }
            }
            .padding()
        })
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this book?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive) {
                viewModel.delete(context: context, book: book)
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleRequestDelete)
        }
        .alert(isPresented: $viewModel.isShowingError) {
            Alert(title: Text("Failed to Delete Book"), message: Text("Something went wrong when trying to delete the book you requested. Please try again later."))
        }
        .alert(isPresented: $viewModel.isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to the book you requested. Please try again later."))
        }
        .sheet(isPresented: $viewModel.showingEditSheet) {
            EditBookScreen(book: book)
        }
        .contextMenu {
            IconButton(title: viewModel.getFavoriteButtonTitle(book: book), icon: viewModel.getFavoriteButtonIcon(book: book)) {
                viewModel.toggleFavorite(context: context, book: book)
            }
            
            IconButton(title: "Edit Book", icon: "pencil", action: viewModel.toggleEditSheet)
            
            IconButton(title: "Delete", icon: "trash", action: viewModel.toggleRequestDelete)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            IconButton(title: viewModel.getFavoriteButtonTitle(book: book), icon: viewModel.getFavoriteButtonIcon(book: book)) {
                viewModel.toggleFavorite(context: context, book: book)
            }
            
            IconButton(title: "Edit Book", icon: "pencil", action: viewModel.toggleEditSheet)
            
            IconButton(title: "Delete", icon: "trash", action: viewModel.toggleRequestDelete)
        }
    }
}
