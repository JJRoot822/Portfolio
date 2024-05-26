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
    
    var bookList: BookList
    
    @Query private var books: [Book]
    
    @State private var selectedBooks = Set<Book>()
    @State private var isShowingSaveError = false
    
    var body: some View {
        NavigationStack {
            List(selection: $selectedBooks) {
                ForEach(books) { book in
                    Text(book.title)
                        .tag(book)
                }
            }
            .toolbar {
                Button("Add", action: addBooksToBookList)
            }
            .navigationTitle(Text("Add Books"))
        }
        .alert(isPresented: $isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when you tried to add books to the list \(bookList.title). Please try again later."), dismissButton: .default(Text("Ok")))
        }
    }
    
    private func addBooksToBookList() {
        selectedBooks.forEach {
            bookList.books.append($0)
        }
        
        do {
            try context.save()
        } catch {
            isShowingSaveError = true
        }
    }
}
