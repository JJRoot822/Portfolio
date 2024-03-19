//
//  AddAuthorScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 3/9/24.
//

import SwiftUI
import SwiftData

struct AddAuthorScreen: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var authorName: String = ""
    @State private var authorIsFavorite: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Author Name", text: $authorName)
                Toggle("Is a Favorite Author", isOn: $authorIsFavorite)
                
                Button("Cancel", role: .cancel, action: cancelAddAuthor)
                Button("Add Author", action: addAuthor)
            }
            .navigationTitle(Text("Add New Author"))
            .navigationBarTitleDisplayMode(.large)
        }
        .interactiveDismissDisabled()
    }
    
    private func cancelAddAuthor() {
        dismiss()
    }
    
    private func addAuthor() {
        let author: Author = Author(name: authorName, isFavorited: authorIsFavorite, books: [])
        modelContext.insert(author)
        
        save()
    }
    
    private func save() {
        do {
            try modelContext.save()
            
            dismiss()
        } catch {
            fatalError("Failed to save")
        }
    }
}

