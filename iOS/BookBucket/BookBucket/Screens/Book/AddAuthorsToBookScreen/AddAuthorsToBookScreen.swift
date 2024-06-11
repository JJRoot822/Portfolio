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
    
    @State private var viewModel = ViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                List(selection: $viewModel.selectedAuthors) {
                    ForEach(authors) { author in
                        if !book.authors.contains(author) {
                            Text(author.name)
                                .tag(author)
                        }
                    }
                }
                
                Form {
                    Button("Cancel", role: .cancel) {
                        viewModel.cancel()
                    }
                    
                    Button("Add Authors to \(book.title)") {
                        viewModel.addAuthorsToBook(context: context, book: book)
                    }
                }
            }
            .toolbar {
                EditButton()
            }
            .navigationTitle(Text("Add Authors"))
        }
        .alert(isPresented: $viewModel.isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when you tried to add authors to \(book.title). Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .onChange(of: viewModel.shouldDismiss) {
            if viewModel.shouldDismiss {
                dismiss()
            }
        }
    }
}
