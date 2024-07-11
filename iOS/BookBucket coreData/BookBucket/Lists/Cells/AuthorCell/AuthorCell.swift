//
//  AuthorCell.swift
//  BookBucket
//
//  Created by Joshua Root on 4/6/24.
//

import SwiftUI
import CoreData

struct AuthorCell: View {
    @Environment(\.managedObjectContext) var context
    
    @State private var viewModel = ViewModel()
    
    var author: Author
    
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
                    Text(author.authorName)
                    
                    Text("Books Authored: \(author.authorBooks)")
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding()
            
        })
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this author?", isPresented: $viewModel.isDeleteRequested, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                viewModel.delete(context: context, author: author)
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleRequestDelete)
        }
        .alert(isPresented: viewModel.isShowingAlert, error: viewModel.error) { _ in
            Button("Ok") {
                viewModel.isShowingAlert = false
            }
        } message: { error in
            Text(error.failureReason!)
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
