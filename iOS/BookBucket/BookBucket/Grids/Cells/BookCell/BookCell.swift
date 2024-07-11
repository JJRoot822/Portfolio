//
//  BookCell.swift
//  BookBucket
//
//  Created by Joshua Root on 5/14/24.
//

import SwiftUI
import SwiftData

struct BookCell: View {
    @Environment(\.modelContext) var context
    
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
                        .foregroundStyle(Color.secondary)
                        .accessibilityHidden(true)
                }
                
                HStack(alignment: .top, spacing: 10) {
                    Image(systemName: viewModel.getFavoriteIndicatorIcon(book: book))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(viewModel.getFavoriteIndicatorIconColor(book: book))
                        .accessibilityLabel(Text(viewModel.getFavoritedStatus(book: book)))
                    
                    Text(book.title)
                        .foregroundStyle(Color(uiColor: .label))
                        .lineLimit(2, reservesSpace: true)
                }
                
                if let firstAuthor = book.authors.first {
                    Text(firstAuthor.name)
                        .foregroundStyle(Color.secondary)
                } else {
                    Text("No Author")
                        .foregroundStyle(Color.secondary)
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
        .alert(isPresented: $viewModel.isShowingDeleteError) {
            Alert(title: Text("Failed to Delete Book"), message: Text("Something went wrong when trying to delete this book. Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .alert(isPresented: $viewModel.isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to this book. Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .confirmationDialog("Are you sure you want to delete this book?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive) {
                viewModel.delete(context: context, book: book)
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleRequestDelete)
        }
    }
}
