//
//  BookListBookCell.swift
//  BookBucket
//
//  Created by Joshua Root on 5/25/24.
//

import SwiftUI
import SwiftData

struct BookListBookCell: View {
    @Environment(\.modelContext) var context
    
    @Bindable var bookList: BookList
    @Bindable var book: Book
    
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
                        .accessibilityHidden(true)
                }
                
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: viewModel.getFavoriteIndicatorIcon(book: book))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(viewModel.getFavoriteIndicatorColor(book: book))
                        .accessibilityLabel(Text(viewModel.getFavoritedStatus(book: book)))
                    
                    ProgressView(value: viewModel.getReadingProgress(book: book))
                    
                    Text(book.title)
                }
                
                if let firstAuthor = book.authors.first {
                    Text(firstAuthor.name)
                } else {
                    Text("No Author")
                }
            }
        })
        .accessibilityElement(children: .combine)
        .accessibilityInputLabels([ Text("\(book.title)") ])
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
            viewModel.showEditBookCoverScreen()
        }, label: {
            Text("Edit Book Cover")
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
            
            Button(action: viewModel.showEditBookCoverScreen) {
                Label("Edit Book Cover", systemImage: "pencil")
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
        .sheet(isPresented: $viewModel.isShowingEditBookCover) {
            EditBookCoverScreen(book: book)
        }
        .alert(isPresented: $viewModel.isShowingRemoveError) {
            Alert(title: Text("Failed to Remove Book"), message: Text("Something went wrong when trying to remove this book from \(bookList.title). Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .alert(isPresented: $viewModel.isShowingDeleteError) {
            Alert(title: Text("Failed to Delete Book"), message: Text("Something went wrong when trying to delete this book. Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .alert(isPresented: $viewModel.isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to this book. Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .confirmationDialog("Are you sure you want to remove this book from \(bookList.title)?", isPresented: $viewModel.isRemoveRequested) {
            Button("Remove from \(bookList.title)", role: .destructive) {
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
