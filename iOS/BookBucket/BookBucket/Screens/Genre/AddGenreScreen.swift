//
//  AddGenreScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 3/10/24.
//

import SwiftUI
import SwiftData

struct AddGenreScreen: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var genreName: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Genre Name", text: $genreName)
                
                Button("Cancel", role: .cancel, action: cancelAddGenre)
                Button("Add Genre", action: addGenre)
            }
            .navigationTitle(Text("Add New Genre"))
            .navigationBarTitleDisplayMode(.large)
        }
        .interactiveDismissDisabled()
    }
    
    private func cancelAddGenre() {
        dismiss()
    }
    
    private func addGenre() {
        let genre: Genre = Genre(name: genreName, books: [])
        modelContext.insert(genre)
        
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

