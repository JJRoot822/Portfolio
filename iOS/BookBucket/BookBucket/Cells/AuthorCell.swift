//
//  AuthorCell.swift
//  BookBucket
//
//  Created by Joshua Root on 3/7/24.
//

import SwiftUI

struct AuthorCell: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var isShowingEditScreen: Bool = false
    
    var author: Author
    
    var favoriteButtonTitle: String {
        return author.isFavorited ? "Remove From Favorites" : "Mark as Favorite"
    }
    
    var favoriteButtonIcon: String {
        return author.isFavorited ? "star.slash.fill" : "star.fill"
    }
    
    var cellFavoriteIndicatorIcon: String {
        return author.isFavorited ? "star.fill" : "star"
    }
    
    var cellFavoriteIndicatorIconColor: Color {
        return author.isFavorited ? .yellow : .secondary
    }
    
    var cellAccessibilityLabel: String {
        if author.isFavorited {
            return "\(author.name), author of \(author.books.count) books, favorite"
        }
        
        return "\(author.name), author of \(author.books.count) books"
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: cellFavoriteIndicatorIcon)
                .resizable()
                .frame(width: 44, height: 44)
                .foregroundStyle(cellFavoriteIndicatorIconColor)
                .onTapGesture(perform: toggleFavorite)
            
            VStack(alignment: .leading) {
                Text("\(author.name)")
                
                Text("Author of \(author.books.count) Books")
                    .foregroundStyle(Color.secondary)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(cellAccessibilityLabel))
        .contextMenu {
            IconButton(title: favoriteButtonTitle, icon: favoriteButtonIcon, action: toggleFavorite)
            IconButton(title: "Edit", icon: "pencil", action: showEditScreen)
            IconButton(title: "Delete", icon: "trash", action: delete)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            IconButton(title: "Delete", icon: "trash", action: delete).tint(.red)
            IconButton(title: "Edit", icon: "pencil", action: showEditScreen).tint(.blue)
            IconButton(title: favoriteButtonTitle, icon: favoriteButtonIcon, action: toggleFavorite).tint(.yellow)
        }
        .sheet(isPresented: $isShowingEditScreen, content: {
            EditAuthorScreen(author: author)
        })
    }
    
    private func delete () {
        modelContext.delete(author)
        save()
    }
    
    private func toggleFavorite() {
        author.isFavorited.toggle()
        save()
    }
    
    private func showEditScreen() {
        isShowingEditScreen = true
    }
    
    private func save() {
        do {
            try modelContext.save()
        } catch {
            fatalError("Failed to save")
        }
    }
}
