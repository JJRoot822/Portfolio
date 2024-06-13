//
//  GenreCell.swift
//  BookBucket
//
//  Created by Joshua Root on 4/26/24.
//

import SwiftUI
import SwiftData

struct GenreCell: View {
    @Environment(\.modelContext) var context
    
    @State private var viewModel = ViewModel()
    
    @Bindable var genre: Genre
    
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
                    Text(genre.name)
                    
                    Text("Books: \(genre.books.count)")
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding()
        })
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this genre?", isPresented: $viewModel.isDeleteRequested) {
            Button("Delete", role: .destructive) {
                viewModel.delete(context: context, genre: genre)
            }
            
            Button("Cancel", role: .cancel, action: viewModel.toggleRequestDelete)
        }
        .alert(isPresented: $viewModel.isShowingError) {
            Alert(title: Text("Failed to Delete Genre"), message: Text("Something went wrong when trying to delete the genre you requested. Please try again later."))
        }
        .alert(isPresented: $viewModel.isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes to the genre you requested. Please try again later."))
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
