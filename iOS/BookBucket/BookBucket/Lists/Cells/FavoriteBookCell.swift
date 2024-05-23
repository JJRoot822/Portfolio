//
//  FavoriteBookCell.swift
//  BookBucket
//
//  Created by Joshua Root on 4/28/24.
//

import SwiftUI
import SwiftData

struct FavoriteBookCell: View {
    @Environment(\.modelContext) var context
    
    @State private var showingEditSheet: Bool = false
    @State private var isDeleteRequested: Bool = false
    @State private var isShowingError: Bool = false
    @State private var isShowingSaveError: Bool = false
    
    @Bindable var book: Book
    
    var favoriteButtonTitle: LocalizedStringKey {
        return book.isFavorite
            ? "Remove from Favorites"
            : "Add to Favorites"
    }
    
    var favoriteButtonIcon: String {
        return book.isFavorite
            ? "star.slash"
            : "star"
    }
    
    var bookCoverImage: Image {
        if let imageData = book.coverImage,
           let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        }
        
        return Image(systemName: "book.closed")
    }
    
    var body: some View {
        HStack(spacing: 20) {
            bookCoverImage
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 5))
            
            VStack(alignment: .leading) {
                Text(book.title)
                
                Text("\(book.authors.count) authors")
                    .foregroundStyle(Color.secondary)
            }
        }
        .padding()
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this book?", isPresented: $isDeleteRequested) {
            Button("Delete", role: .destructive, action: deleteBook)
        }
        .alert(isPresented: $isShowingError) {
            Alert(title: Text("Failed to Delete Book"), message: Text("Something went wrong when trying to delete the book you requested. Please try again later."))
        }
        .alert(isPresented: $isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to the book you requested. Please try again later."))
        }
        .sheet(isPresented: $showingEditSheet) {
            EditBookScreen(book: book)
        }
        .contextMenu {
            IconButton(title: favoriteButtonTitle, icon: favoriteButtonIcon, action: toggleFavorite)
            IconButton(title: "Edit Book", icon: "pencil", action: toggleEditSheet)
            IconButton(title: "Delete", icon: "trash", action: requestDelete)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            IconButton(title: favoriteButtonTitle, icon: favoriteButtonIcon, action: toggleFavorite)
            IconButton(title: "Edit Book", icon: "pencil", action: toggleEditSheet)
            IconButton(title: "Delete", icon: "trash", action: requestDelete)
        }
    }
    
    private func toggleEditSheet() {
        self.showingEditSheet = true
    }
    
    private func deleteBook() {
        let dataHelper = DataHelper()
        let result = dataHelper.delete(context: context, model: book)
        
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
        book.isFavorite.toggle()
        
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
