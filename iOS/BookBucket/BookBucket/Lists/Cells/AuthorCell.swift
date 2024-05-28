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
    
    @State private var showingEditSheet: Bool = false
    @State private var isDeleteRequested: Bool = false
    @State private var isShowingError: Bool = false
    @State private var isShowingSaveError: Bool = false
    
    @Bindable var author: Author
    
    var favoriteButtonTitle: LocalizedStringKey {
        return author.isFavorited
            ? "Remove from Favorites"
            : "Add to Favorites"
    }
    
    var favoriteButtonIcon: String {
        return author.isFavorited
            ? "star.slash"
            : "star"
    }
    
    var favoriteIndicatorIcon: String {
        return author.isFavorited ? "star.fill" : "star"
    }
    
    var favoriteIndicatorLabel: String {
        return author.isFavorited ? "Favorited" : "Not Favorited"
    }
    
    var body: some View {
        NavigationLink(destination: {
            AuthorDetailsScreen(author: author)
        }, label: {
            HStack(spacing: 20) {
                Image(systemName: favoriteIndicatorIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundStyle(author.isFavorited ? Color.yellow : Color.secondary)
                    .accessibilityLabel(Text(favoriteIndicatorLabel))
                VStack(alignment: .leading) {
                    Text(author.name)
                    
                    Text("Books Authored: \(author.books.count)")
                        .foregroundStyle(Color.secondary)
                }
            }
            .padding()
            
        })
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this author?", isPresented: $isDeleteRequested) {
            Button("Delete", role: .destructive, action: deleteAuthor)
        }
        .alert(isPresented: $isShowingError) {
            Alert(title: Text("Failed to Delete Author"), message: Text("Something went wrong when trying to delete the author you requested. Please try again later."))
        }
        .alert(isPresented: $isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes to the book you requested. Please try again later."))
        }
        .sheet(isPresented: $showingEditSheet) {
            EditAuthorScreen(author: author)
        }
        .contextMenu {
            IconButton(title: favoriteButtonTitle, icon: favoriteButtonIcon, action: toggleFavorite)
            IconButton(title: "Edit Author", icon: "pencil", action: toggleEditSheet)
            IconButton(title: "Delete", icon: "trash", action: requestDelete)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            IconButton(title: favoriteButtonTitle, icon: favoriteButtonIcon, action: toggleFavorite)
            IconButton(title: "Edit Author", icon: "pencil", action: toggleEditSheet)
            IconButton(title: "Delete", icon: "trash", action: requestDelete)
        }
    }
    
    private func toggleEditSheet() {
        self.showingEditSheet = true
    }
    
    private func deleteAuthor() {
        let dataHelper = DataHelper()
        let result = dataHelper.delete(context: context, model: author)
        
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
        author.isFavorited.toggle()
        
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
