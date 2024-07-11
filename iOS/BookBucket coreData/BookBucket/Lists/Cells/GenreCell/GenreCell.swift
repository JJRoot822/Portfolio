//
//  GenreCell.swift
//  BookBucket
//
//  Created by Joshua Root on 4/26/24.
//

import SwiftUI
import CoreData

struct GenreCell: View {
    @Environment(\.managedObjectContext) var context
    
    @State private var viewModel = ViewModel()
    
    var genre: Genre
    
    var body: some View {
        NavigationLink(destination: {
            GenreDetailsScreen(genre: genre)
        }, label: {
            HStack(spacing: 20) {
                Image(systemName: viewModel.getFavoriteIndicatorIcon(genre: genre))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(viewModel.getFavoriteIndicatorColor(genre: genre))
                    .accessibilityLabel(Text(viewModel.getFavoriteIndicatorLabel(genre: genre)))
                
                VStack(alignment: .leading) {
                    Text(genre.genreName)
                    
                    Text("Books: \(genre.genreBooks.count)")
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding()
        })
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this genre?", isPresented: $viewModel.isDeleteRequested, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                viewModel.delete(context: context, genre: genre)
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
            EditGenreScreen(genre: genre)
        }
        .contextMenu {
            IconButton(title: viewModel.getFavoriteButtonTitle(genre: genre), icon: viewModel.getFavoriteButtonIcon(genre: genre)) {
                viewModel.toggleFavorite(context: context, genre: genre)
            }
            
            IconButton(title: "Edit Genre", icon: "pencil", action: viewModel.toggleEditSheet)
            
            IconButton(title: "Delete", icon: "trash", action: viewModel.toggleRequestDelete)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            IconButton(title: viewModel.getFavoriteButtonTitle(genre: genre), icon: viewModel.getFavoriteButtonIcon(genre: genre)) {
                viewModel.toggleFavorite(context: context, genre: genre)
            }
            
            IconButton(title: "Edit Genre", icon: "pencil", action: viewModel.toggleEditSheet)
            
            IconButton(title: "Delete", icon: "trash", action: viewModel.toggleRequestDelete)
        }
    }
}
