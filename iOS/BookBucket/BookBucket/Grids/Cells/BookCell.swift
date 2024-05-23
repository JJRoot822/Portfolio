//
//  BookCell.swift
//  BookBucket
//
//  Created by Joshua Root on 5/14/24.
//

import SwiftUI
import SwiftData

struct BookCell: View {
    @Environment(\.modelContext) var context
    
    @Bindable var book: Book
    
    @State private var isShowingDeleteError: Bool = false
    @State private var isShowingSaveError: Bool = false
    @State private var isDeleteRequested: Bool = false

    var body: some View {
        VStack(spacing: 10) {
            if let imageData = book.coverImage,
               let coverImage = UIImage(data: imageData) {
                Image(uiImage: coverImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 125, height: 125)
            } else {
                Image(systemName: "book.closed")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 125, height: 125)
            }
            
            HStack(spacing: 10) {
                Image(systemName: book.isFavorite ? "star.fill" : "star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(book.isFavorite ? Color.yellow : Color.secondary)
            
                Text(book.title)
            }
            
            if let firstAuthor = book.authors.first {
                Text(firstAuthor.name)
            } else {
                Text("No Author")
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("\(book.title)"))
        .accessibilityInputLabels([ Text("\(book.title)") ])
        .contextMenu {
            Button(action: toggleFavorite) {
                Label(book.isFavorite ? "Remove from Favorites" : "Add to Favorites", systemImage: "star")
            }
            
            Button(role: .destructive, action: toggleRequestDelete) {
                Label("Delete Book", systemImage: "trash")
            }
        }
        .alert(isPresented: $isShowingDeleteError) {
            Alert(title: Text("Failed to Delete Book"), message: Text("Something went wrong when trying to delete this book. Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .alert(isPresented: $isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to this book. Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .confirmationDialog("Are you sure you want to delete this book?", isPresented: $isDeleteRequested) {
            Button("Delete", role: .destructive, action: delete)
            
            Button("Cancel", role: .cancel, action: toggleRequestDelete)
        }
    }
    
    private func toggleFavorite() {
        book.isFavorite.toggle()
        
        saveChanges()
    }
    
    private func saveChanges() {
        let dataHelper = DataHelper()
        let result = dataHelper.save(context: context)
        
        switch result {
        case .success(()):
            return
        case .failure(_):
            if context.hasChanges {
                context.rollback()
            }
            
            
            self.isShowingSaveError = true
            
            return
        }
    }
    
    private func toggleRequestDelete() {
        self.isDeleteRequested.toggle()
    }
    
    private func delete() {
        let dataHelper = DataHelper()
        let result = dataHelper.delete(context: context, model: book)
        
        switch result {
        case .success(()):
            return
        case .failure(_):
            self.isShowingDeleteError = true
            
            return
        }
    }
}
