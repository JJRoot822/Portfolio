//
//  EditAuthorScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 3/7/24.
//

import SwiftUI

struct EditAuthorScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Bindable var author: Author
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $author.name)
                Toggle("Favorite", isOn: $author.isFavorited)
                
                Button("Save", action: save)
                Button("Cancel", role: .cancel, action: cancelEdit)
                Button("Delete Author", role: .destructive, action: delete)
                
                
            }
            .navigationTitle(Text("Edit Author"))
        }
        .interactiveDismissDisabled()
    }
    
    private func cancelEdit() {
        modelContext.rollback()
        
        dismiss()
    }
    
    private func delete() {
        modelContext.delete(author)
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

