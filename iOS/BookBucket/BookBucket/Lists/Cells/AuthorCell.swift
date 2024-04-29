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
    @State private var errorMessage: LocalizedStringKey?
    
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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(author.name)
            
            Text("\(author.books.count) books authored")
                .foregroundStyle(Color.secondary)
        }
        .padding()
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this author?", isPresented: $isDeleteRequested) {
            Button("Delete", role: .destructive, action: deleteAuthor)
        }
        .alert(isPresented: $isShowingError) {
            Alert(title: Text("Something Went Wrong"), message: Text(errorMessage ?? LocalizedStringKey("Some unknown error occurred. Please try again later.")))
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
        case .failure(let error):
            self.errorMessage = LocalizedStringKey(error.localizedDescription)
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
        case .failure(let error):
            self.errorMessage = LocalizedStringKey(error.localizedDescription)
            self.isShowingError = true
        }
    }
}
