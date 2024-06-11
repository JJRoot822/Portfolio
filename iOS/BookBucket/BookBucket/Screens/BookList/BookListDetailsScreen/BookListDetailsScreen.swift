//
//  BookListDetailsScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/24/24.
//

import SwiftUI

struct BookListDetailsScreen: View {
    var bookList: BookList
    
    @State private var viewModel = ViewModel()
    var body: some View {
        BookListBooksGrid(bookList: bookList, sortCriteria: viewModel.sortCriteria, searchTerm: viewModel.searchTerm)
            .navigationTitle(Text("\(bookList.title)"))
            .searchable(text: $viewModel.searchTerm, prompt: Text("Search for a Book"))
            .id(viewModel.id)
            .sheet(isPresented: $viewModel.isShowingAddBooksToListScreen, onDismiss: {
                viewModel.id = UUID()
            }) {
                AddBooksToBookListScreen(bookList: bookList)
            }
            .toolbar {
                BookSortOrderPicker(selection: $viewModel.sortCriteria)
                
                Button(action: viewModel.showAddBookToListScreen) {
                    Label("Add Books", systemImage: "plus")
                }
            }
    }
}
