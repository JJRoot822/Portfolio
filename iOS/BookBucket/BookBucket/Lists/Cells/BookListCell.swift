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
    
    @State private var showingEditSheet: Bool = false
    @State private var isDeleteRequested: Bool = false
    @State private var isShowingError: Bool = false
    @State private var isShowingSaveError: Bool = false
    
    @Bindable var bookList: BookList

    var favoriteButtonTitle: LocalizedStringKey {
        return bookList.isFavorite
            ? "Remove from Favorites"
            : "Add to Favorites"
    }
    
    var favoriteButtonIcon: String {
        return bookList.isFavorite
            ? "star.slash"
            : "star"
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "books.vertical")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundStyle(Color.color(forName: bookList.color))
            
            VStack(alignment: .leading) {
                Text(bookList.title)
                
                Text("\(bookList.books.count) books")
                    .foregroundStyle(Color.secondary)
            }
        }
        .padding()
        .accessibilityElement(children: .combine)
        .confirmationDialog("Are you sure you want to delete this book list?", isPresented: $isDeleteRequested) {
            Button("Delete", role: .destructive, action: deleteBookList)
        }
        .alert(isPresented: $isShowingError) {
            Alert(title: Text("Failed to Delete Book List"), message: Text("Something went wrong when trying to delete the book list you requested. Please try again later."))
        }
        .alert(isPresented: $isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes to the book list you requested. Please try again later."))
        }
        .sheet(isPresented: $showingEditSheet) {
            EditBookListScreen(bookList: bookList)
        }
        .contextMenu {
            IconButton(title: favoriteButtonTitle, icon: favoriteButtonIcon, action: toggleFavorite)
            IconButton(title: "Edit Book List", icon: "pencil", action: toggleEditSheet)
            IconButton(title: "Delete", icon: "trash", action: requestDelete)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            IconButton(title: favoriteButtonTitle, icon: favoriteButtonIcon, action: toggleFavorite)
            IconButton(title: "Edit Book List", icon: "pencil", action: toggleEditSheet)
            IconButton(title: "Delete", icon: "trash", action: requestDelete)
        }
    }
    
    private func toggleEditSheet() {
        self.showingEditSheet = true
    }
    
    private func deleteBookList() {
        let dataHelper = DataHelper()
        let result = dataHelper.delete(context: context, model: bookList)
        
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
        bookList.isFavorite.toggle()
        
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
