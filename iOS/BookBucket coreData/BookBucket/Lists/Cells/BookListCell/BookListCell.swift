//
//  BookListCell.swift
//  BookBucket
//
//  Created by Joshua Root on 4/29/24.
//

import SwiftUI
import CoreData

struct BookListCell: View {
    @Environment(\.managedObjectContext) var context
    
    @State private var viewModel = ViewModel()
    
    var bookList: BookList

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
                    Text(bookList.listName)
                    
                    Text("Books: \(bookList.listBooks.count)")
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding()
        })
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this book list?", isPresented: $viewModel.isDeleteRequested, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                viewModel.delete(context: context, bookList: bookList)
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleRequestDelete)
        }
        .alert(isPresented: $viewModel.isShowingAlert, error: viewModel.error) { _ in
            Button("Ok") {
                viewModel.isShowingAlert = false
            }
        } message: { error in
            Text(error.failureReason!)
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
