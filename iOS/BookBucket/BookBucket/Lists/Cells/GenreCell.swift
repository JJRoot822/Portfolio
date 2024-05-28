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
    
    @State private var showingEditSheet: Bool = false
    @State private var isDeleteRequested: Bool = false
    @State private var isShowingError: Bool = false
    @State private var isShowingSaveError: Bool = false
    
    @Bindable var genre: Genre

    var favoriteButtonTitle: LocalizedStringKey {
        return genre.isFavorite
            ? "Remove from Favorites"
            : "Add to Favorites"
    }
    
    var favoriteButtonIcon: String {
        return genre.isFavorite
            ? "star.slash"
            : "star"
    }
    
    var favoriteIndicatorIcon: String {
        return genre.isFavorite ? "star.fill" : "star"
    }
    
    var favoriteIndicatorLabel: String {
        return genre.isFavorite ? "Favorited" : "Not Favorited"
    }
    
    var body: some View {
        NavigationLink(destination: {
            GenreDetailsScreen(genre: genre)
        }, label: {
            HStack(spacing: 20) {
                Image(systemName: favoriteIndicatorIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(genre.isFavorite ? Color.yellow : Color.secondary)
                    .accessibilityLabel(Text(favoriteIndicatorLabel))
                
                VStack(alignment: .leading) {
                    Text(genre.name)
                    
                    Text("Books: \(genre.books.count)")
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding()
        })
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this genre?", isPresented: $isDeleteRequested) {
            Button("Delete", role: .destructive, action: deleteGenre)
        }
        .alert(isPresented: $isShowingError) {
            Alert(title: Text("Failed to Delete Genre"), message: Text("Something went wrong when trying to delete the genre you requested. Please try again later."))
        }
        .alert(isPresented: $isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes to the genre you requested. Please try again later."))
        }
        .sheet(isPresented: $showingEditSheet) {
            EditGenreScreen(genre: genre)
        }
        .contextMenu {
            IconButton(title: favoriteButtonTitle, icon: favoriteButtonIcon, action: toggleFavorite)
            IconButton(title: "Edit Genre", icon: "pencil", action: toggleEditSheet)
            IconButton(title: "Delete", icon: "trash", action: requestDelete)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            IconButton(title: favoriteButtonTitle, icon: favoriteButtonIcon, action: toggleFavorite)
            IconButton(title: "Edit Genre", icon: "pencil", action: toggleEditSheet)
            IconButton(title: "Delete", icon: "trash", action: requestDelete)
        }
    }
    
    private func toggleEditSheet() {
        self.showingEditSheet = true
    }
    
    private func deleteGenre() {
        let dataHelper = DataHelper()
        let result = dataHelper.delete(context: context, model: genre)
        
        switch result {
        case .success(()):
            return
        case .failure(_):
            self.isShowingError = true
        }
    }
    
    private func requestDelete() {
        self.isDeleteRequested = true
    }
    
    private func toggleFavorite() {
        genre.isFavorite.toggle()
        
        let dataHelper = DataHelper()
        let result = dataHelper.save(context: context)
        
        switch result {
        case .success(()):
            return
        case .failure(_):
            self.isShowingSaveError = true
        }
    }
}
