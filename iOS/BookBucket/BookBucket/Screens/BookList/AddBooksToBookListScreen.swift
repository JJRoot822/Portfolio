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
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List(selection: $viewModel.selectedBooks) {
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
                EditButton()
            }
            
            Form {
                Button("Cancel", role: .cancel, action: viewModel.cancel)
                
                Button("Add") {
                    viewModel.addBooksToBookList(context: context, bookList: bookList)
                }
            }
            .navigationTitle(Text("Add Books"))
        }
        .alert(isPresented: $viewModel.isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when you tried to add books to the list \(bookList.title). Please try again later."), dismissButton: .default(Text("Ok")))
        }
    }
}
