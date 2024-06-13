//
//  AuthorCell.swift
//  BookBucket
//
//  Created by Joshua Root on 4/6/24.
//

import SwiftUI
import SwiftData

struct AuthorCell: View {
    @Environment(\.modelContext) var context
    
    @State private var viewModel = ViewModel()
    
    @Bindable var author: Author
    
    var body: some View {
        NavigationLink(destination: {
            AuthorDetailsScreen(author: author)
        }, label: {
            HStack(spacing: 20) {
                Image(systemName: viewModel.getFavoriteIndicatorIcon(author: author))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(viewModel.getFavoriteIndicatorColor(author: author))
                    .accessibilityLabel(Text(viewModel.getFavoriteIndicatorLabel(author: author)))
                
                VStack(alignment: .leading) {
                    Text(author.name)
                    
                    Text("Books Authored: \(author.books.count)")
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding()
            
        })
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this author?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive) {
                viewModel.delete(context: context, author: author)
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleRequestDelete)
        }
        .alert(isPresented: $viewModel.isShowingError) {
            Alert(title: Text("Failed to Delete Author"), message: Text("Something went wrong when trying to delete the author you requested. Please try again later."))
        }
        .alert(isPresented: $viewModel.isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes to the book you requested. Please try again later."))
        }
        .sheet(isPresented: $viewModel.showingEditSheet) {
            EditAuthorScreen(author: author)
        }
        .contextMenu {
            IconButton(title: viewModel.getFavoriteButtonTitle(author: author), icon: viewModel.getFavoriteButtonIcon(author: author)) {
                viewModel.toggleFavorite(context: context, author: author)
            }
            
            IconButton(title: "Edit Author", icon: "pencil", action: viewModel.toggleEditSheet)
            
            IconButton(title: "Delete", icon: "trash", action: viewModel.toggleRequestDelete)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            IconButton(title: viewModel.getFavoriteButtonTitle(author: author), icon: viewModel.getFavoriteButtonIcon(author: author)) {
                viewModel.toggleFavorite(context: context, author: author)
            }
            
            IconButton(title: "Edit Author", icon: "pencil", action: viewModel.toggleEditSheet)
            
            IconButton(title: "Delete", icon: "trash", action: viewModel.toggleRequestDelete)
        }
    }
}
