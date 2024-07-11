//
//  FavoriteBookCell.swift
//  BookBucket
//
//  Created by Joshua Root on 4/28/24.
//

import SwiftUI
import SwiftData

struct FavoriteBookCell: View {
    @Environment(\.managedObjectContext) var context
    
    @State private var viewModel = ViewModel()
    
    var book: Book
    
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
                    Text(book.bookTitle)
                    
                    Text("bookAuthors: \(book.bookAuthors.count)")
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding()
        })
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this book?", isPresented: $viewModel.isDeleteRequested, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                viewModel.delete(context: context, book: book)
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleRequestDelete)
        }
        .alert(isPresented: $viewModel.isShowingAlert, error: viewModel.error) { _ in
            Button("OK") {
                viewModel.isShowingAlert = false
            }
        } message: { error in
            Text(error.failureReason!)
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
