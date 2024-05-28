//
//  AddBooksToBookListScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI
import SwiftData

struct AddBooksToBookListScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var bookList: BookList
    
    @Query private var books: [Book]
    
    @State private var selectedBooks = Set<Book>()
    @State private var isShowingSaveError = false
    
    var body: some View {
        NavigationStack {
            List(selection: $selectedBooks) {
                Section(footer: Text("Tap the \"Edit\" button to select multiple books")) {
                    ForEach(books) { book in
                        if !bookList.books.contains(book) {
                            Text(book.title)
                                .tag(book)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        EditButton()
                    
                        Spacer()
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: addBooksToBookList)
                }
            }
            .navigationTitle(Text("Add Books"))
        }
        .alert(isPresented: $isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when you tried to add books to the list \(bookList.title). Please try again later."), dismissButton: .default(Text("Ok")))
        }
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func addBooksToBookList() {
        selectedBooks.forEach {
            bookList.books.append($0)
        }
        
        do {
            try context.save()
            dismiss()
        } catch {
            isShowingSaveError = true
        }
    }
}
