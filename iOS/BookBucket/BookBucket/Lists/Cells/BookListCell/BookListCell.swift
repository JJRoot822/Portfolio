//
//  BookListCell.swift
//  BookBucket
//
//  Created by Joshua Root on 4/29/24.
//

import SwiftUI
import SwiftData

struct BookListCell: View {
    @Environment(\.modelContext) var context
    
    @State private var viewModel = ViewModel()
    
    @Bindable var bookList: BookList

    var body: some View {
        NavigationLink(destination: {
            BookListDetailsScreen(bookList: bookList)
        }, label: {
            HStack(spacing: 20) {
                Image(systemName:viewModel.getFavoriteIndicatorIcon(bookList: bookList))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(viewModel.getFavoriteIndicatorColor(bookList: bookList))
                    .accessibilityLabel(Text(viewModel.getFavoriteIndicatorLabel(bookList: bookList)))
                
                Image(systemName: "books.vertical")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(Color.color(forName: bookList.color) ?? .accentColor)
                
                VStack(alignment: .leading) {
                    Text(bookList.title)
                    
                    Text("Books: \(bookList.books.count)")
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding()
        })
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this book list?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive) {
                viewModel.delete(context: context, bookList: bookList)
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleRequestDelete)
        }
        .alert(isPresented: $viewModel.isShowingError) {
            Alert(title: Text("Failed to Delete Book List"), message: Text("Something went wrong when trying to delete the book list you requested. Please try again later."))
        }
        .alert(isPresented: $viewModel.isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes to the book list you requested. Please try again later."))
        }
        .sheet(isPresented: $viewModel.showingEditSheet) {
            EditBookListScreen(bookList: bookList)
        }
        .contextMenu {
            IconButton(title: viewModel.getFavoriteButtonTitle(bookList: bookList), icon: viewModel.getFavoriteButtonIcon(bookList: bookList)) {
                viewModel.toggleFavorite(context: context, bookList: bookList)
            }
            
            IconButton(title: "Edit Book List", icon: "pencil", action: viewModel.toggleEditSheet)
            
            IconButton(title: "Delete", icon: "trash", action: viewModel.toggleRequestDelete)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            IconButton(title: viewModel.getFavoriteButtonTitle(bookList: bookList), icon: viewModel.getFavoriteButtonIcon(bookList: bookList)) {
                viewModel.toggleFavorite(context: context, bookList: bookList)
            }
            
            IconButton(title: "Edit Book List", icon: "pencil", action: viewModel.toggleEditSheet)
            
            IconButton(title: "Delete", icon: "trash", action: viewModel.toggleRequestDelete)
        }
    }
}
