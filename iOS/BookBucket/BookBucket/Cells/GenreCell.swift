//
//  GenreCell.swift
//  BookBucket
//
//  Created by Joshua Root on 3/10/24.
//

import SwiftUI

struct GenreCell: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var isShowingEditScreen: Bool = false
    
    var genre: Genre
    
    var cellAccessibilityLabel: String {
        return "\(genre.name), Genre of \(genre.books.count) books"
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(genre.name)")
            
            Text("\(genre.books.count) Books")
                .foregroundStyle(Color.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(cellAccessibilityLabel))
        .contextMenu {
            IconButton(title: "Edit", icon: "pencil", action: showEditScreen)
            IconButton(title: "Delete", icon: "trash", action: delete)
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            IconButton(title: "Delete", icon: "trash", action: delete).tint(.red)
            IconButton(title: "Edit", icon: "pencil", action: showEditScreen).tint(.blue)
        }
        .sheet(isPresented: $isShowingEditScreen, content: {
            EditGenreScreen(genre: genre)
        })
    }
    
    private func delete () {
        modelContext.delete(genre)
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
