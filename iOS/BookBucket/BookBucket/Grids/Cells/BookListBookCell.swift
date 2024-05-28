//
//  BookListBookCell.swift
//  BookBucket
//
//  Created by Joshua Root on 5/25/24.
//

import SwiftUI
import SwiftData

struct BookListBookCell: View {
    @Environment(\.modelContext) var context
    
    @Bindable var bookList: BookList
    @Bindable var book: Book
    
    @State private var isShowingDeleteError: Bool = false
    @State private var isShowingRemoveError: Bool = false
    @State private var isRemoveRequested: Bool = false
    @State private var isShowingSaveError: Bool = false
    @State private var isDeleteRequested: Bool = false
    @State private var isShowingEditBookScreen: Bool = false
    @State private var isShowingEditBookCover: Bool = false

    var bookFavoritedStatus: String {
        return book.isFavorite ? "Favorited" : "Not Favorited"
    }
    
    var favoriteIndicatorIcon: String {
        return book.isFavorite ? "star.fill" : "star"
    }
    
    var favoriteToggleLabel: String {
        return book.isFavorite ? "Remove from Favorites" : "Mark as Favorite"
    }
    
    var favoriteToggleIcon: String {
        return book.isFavorite ? "star.slash" :"star"
    }

    var body: some View {
        NavigationLink(destination: {
            BookDetailsScreen(book: book)
        }, label: {
            VStack(spacing: 10) {
                if let imageData = book.coverImage,
                   let coverImage = UIImage(data: imageData) {
                    Image(uiImage: coverImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125, height: 125)
                    accessibilityHidden(true)
                } else {
                    Image(systemName: "book.closed")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 125, height: 125)
                        .accessibilityHidden(true)
                }
                
                HStack(spacing: 10) {
                    Image(systemName: favoriteIndicatorIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundStyle(book.isFavorite ? Color.yellow : Color.secondary)
                        .accessibilityLabel(Text(bookFavoritedStatus))
                    
                    Text(book.title)
                }
                
                if let firstAuthor = book.authors.first {
                    Text(firstAuthor.name)
                } else {
                    Text("No Author")
                }
            }
        })
        .accessibilityElement(children: .combine)
        .accessibilityInputLabels([ Text("\(book.title)") ])
        .accessibilityAction(action: {
            toggleFavorite()
        }, label: {
            Text(favoriteToggleLabel)
        })
        .accessibilityAction(action: {
            showEditBookScreen()
        }, label: {
            Text("Edit Book")
        })
        .accessibilityAction(action: {
            showEditBookCoverScreen()
        }, label: {
            Text("Edit Book Cover")
        })
        .accessibilityAction(action: {
            toggleRequestDelete()
        }, label: {
            Text("Delete Book")
        })
        .accessibilityAction(action: {
            toggleRequestRemoval()
        }, label: {
            Text("Remove from List")
        })
        .contextMenu {
            Button(action: toggleFavorite) {
                Label(favoriteToggleLabel, systemImage: favoriteToggleIcon)
            }
            
            Button(action: showEditBookScreen) {
                Label("Edit Book", systemImage: "pencil")
            }
            
            Button(action: showEditBookCoverScreen) {
                Label("Edit Book Cover", systemImage: "pencil")
            }
            
            Button(role: .destructive, action: toggleRequestRemoval) {
                Label("Remove from List", systemImage: "trash")
            }
            
            Button(role: .destructive, action: toggleRequestDelete) {
                Label("Delete Book", systemImage: "trash")
            }
        }
        .sheet(isPresented: $isShowingEditBookScreen) {
            EditBookScreen(book: book)
        }
        .sheet(isPresented: $isShowingEditBookCover) {
            EditBookCoverScreen(book: book)
        }
        .alert(isPresented: $isShowingRemoveError) {
            Alert(title: Text("Failed to Remove Book"), message: Text("Something went wrong when trying to remove this book from \(bookList.title). Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .alert(isPresented: $isShowingDeleteError) {
            Alert(title: Text("Failed to Delete Book"), message: Text("Something went wrong when trying to delete this book. Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .alert(isPresented: $isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to this book. Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .confirmationDialog("Are you sure you want to remove this book from \(bookList.title)?", isPresented: $isRemoveRequested) {
            Button("Remove from \(bookList.title)", role: .destructive, action: remove)
            
            Button("Cancel", role: .cancel, action: toggleRequestRemoval)
        }
        .confirmationDialog("Are you sure you want to delete this book?", isPresented: $isDeleteRequested) {
            Button("Delete", role: .destructive, action: delete)
            
            Button("Cancel", role: .cancel, action: toggleRequestDelete)
        }
    }
    
    private func showEditBookScreen() {
        self.isShowingEditBookScreen = true
    }
    
    private func showEditBookCoverScreen() {
        self.isShowingEditBookCover = true
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
    
    private func toggleRequestRemoval() {
        self.isRemoveRequested.toggle()
    }
    
    private func toggleRequestDelete() {
        self.isDeleteRequested.toggle()
    }
    
    private func remove() {
        let indexToRemove = bookList.books.firstIndex(of: book)
        
        if let index = indexToRemove {
            bookList.books.remove(at: index)
            saveChanges()
            
            return
        }
        
        self.isShowingRemoveError
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
