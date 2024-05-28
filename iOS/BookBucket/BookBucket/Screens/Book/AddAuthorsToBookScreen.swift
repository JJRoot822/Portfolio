//
//  AddAuthorsToBookScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI
import SwiftData

struct AddAuthorsToBookScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var book: Book
    
    @Query private var authors: [Author]
    
    @State private var selectedAuthors = Set<Author>()
    @State private var isShowingSaveError = false
    
    var body: some View {
        NavigationStack {
            List(selection: $selectedAuthors) {
                ForEach(authors) { author in
                    Text(author.name)
                        .tag(author)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: addAuthorsToBook)
                }
            }
            .navigationTitle(Text("Add Authors"))
        }
        .alert(isPresented: $isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when you tried to add authors to \(book.title). Please try again later."), dismissButton: .default(Text("Ok")))
        }
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func addAuthorsToBook() {
        selectedAuthors.forEach {
            book.authors.append($0)
        }
        
        do {
            try context.save()
            dismiss()
        } catch {
            isShowingSaveError = true
        }
    }
}
