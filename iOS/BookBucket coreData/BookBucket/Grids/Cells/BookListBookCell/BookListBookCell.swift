//
//  BookListBookCell.swift
//  BookBucket
//
//  Created by Joshua Root on 5/25/24.
//

import SwiftUI
import SwiftData

struct BookListBookCell: View {
    @Environment(\.managedObjectContext) var context
    
    var bookList: BookList
    var book: Book
    
    @State private var viewModel = ViewModel()

    var body: some View {
        NavigationLink(destination: {
            BookDetailsScreen(book: book)
        }, label: {
            VStack(spacing: 10) {
                if let imageData = book.coverImage,
                   let coverImage = UIImage(data: imageData) {
                    Image(uiImage: coverImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125, height: 125)
                    accessibilityHidden(true)
                } else {
                    Image(systemName: "book.closed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125, height: 125)
                        .foregroundStyle(Color.secondary)
                        .accessibilityHidden(true)
                }
                
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: viewModel.getFavoriteIndicatorIcon(book: book))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(viewModel.getFavoriteIndicatorColor(book: book))
                        .accessibilityLabel(Text(viewModel.getFavoritedStatus(book: book)))
                    
                    Text(book.bookTitle)
                        .lineLimit(2, reservesSpace: true)
                        .foregroundStyle(Color(uiColor: .label))
                }
                
                if let firstAuthor = book.bookAuthors.first {
                    Text(firstAuthor.authorName)
                        .foregroundStyle(Color.secondary)
                } else {
                    Text("No Author")
                        .foregroundStyle(Color.secondary)
                }
            }
        })
        .accessibilityElement(children: .combine)
        .accessibilityInputLabels([ Text("\(book.bookTitle)") ])
        .accessibilityAction(action: {
            viewModel.toggleFavorite(context: context, book: book)
        }, label: {
            Text(viewModel.getFavoriteToggleLabel(book: book))
        })
        .accessibilityAction(action: {
            viewModel.showEditBookScreen()
        }, label: {
            Text("Edit Book")
        })
        .accessibilityAction(action: {
            viewModel.toggleRequestDelete()
        }, label: {
            Text("Delete Book")
        })
        .accessibilityAction(action: {
            viewModel.toggleRequestRemoval()
        }, label: {
            Text("Remove from List")
        })
        .contextMenu {
            Button {
                viewModel.toggleFavorite(context: context, book: book)
            } label: {
                Label(viewModel.getFavoriteToggleLabel(book: book), systemImage: viewModel.getFavoriteToggleIcon(book: book))
            }
            
            Button(action: viewModel.showEditBookScreen) {
                Label("Edit Book", systemImage: "pencil")
            }
            
            Button(role: .destructive, action: viewModel.toggleRequestRemoval) {
                Label("Remove from List", systemImage: "trash")
            }
            
            Button(role: .destructive, action: viewModel.toggleRequestDelete) {
                Label("Delete Book", systemImage: "trash")
            }
        }
        .sheet(isPresented: $viewModel.isShowingEditBookScreen) {
            EditBookScreen(book: book)
        }
        .alert(isPresented: $viewModel.isShowingAlert, error: viewModel.error) { _ in
            Button("Ok") {
                viewModel.isShowingAlert = false
            }
        } message: { error in
            Text(error.failureReason!)
        }
        .confirmationDialog("Are you sure you want to remove this book from \(bookList.listName)?", isPresented: $viewModel.isRemoveRequested, titleVisibility: .visible) {
            Button("Remove from \(bookList.listName)", role: .destructive) {
                viewModel.remove(context: context, bookList: bookList, book: book)
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleRequestRemoval)
        }
        .confirmationDialog("Are you sure you want to delete this book?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive) {
                viewModel.delete(context: context, book: book)
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleRequestDelete)
        }
    }
}
