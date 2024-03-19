//
//  EditGenreScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 3/10/24.
//

import SwiftUI

struct EditGenreScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @Bindable var genre: Genre
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $genre.name)
                
                Button("Save", action: save)
                Button("Cancel", role: .cancel, action: cancelEdit)
                Button("Delete Genre", role: .destructive, action: delete)
                
                
            }
            .navigationTitle(Text("Edit Genre"))
            .navigationBarTitleDisplayMode(.large)
        }
        .interactiveDismissDisabled()
    }
    
    private func cancelEdit() {
        modelContext.rollback()
        
        dismiss()
    }
    
    private func delete() {
        modelContext.delete(genre)
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

