//
//  BookListDetailsScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/24/24.
//

import SwiftUI
import SwiftData

struct BookListDetailsScreen: View {
    var bookList: BookList
    
    @State private var isShowingAddBooksToListScreen: Bool = false
    @State private var sortCriteria: BookSortCriteria = .titleAscending
    @State private var searchTerm: String = ""
    @State private var id: UUID = UUID()
    
    var body: some View {
        BookListBooksGrid(bookList: bookList, sortCriteria: sortCriteria, searchTerm: searchTerm)
            .navigationTitle(Text("\(bookList.title)"))
            .searchable(text: $searchTerm, prompt: Text("Search for a Book"))
            .id(id)
            .sheet(isPresented: $isShowingAddBooksToListScreen, onDismiss: {
                id = UUID()
            }) {
                AddBooksToBookListScreen(bookList: bookList)
            }
            .toolbar {
                BookSortOrderPicker(selection: $sortCriteria)
                
                Button(action: showAddBookToListScreen) {
                    Label("Add Books", systemImage: "plus")
                }
            }
    }
    
    private func showAddBookToListScreen() {
        self.isShowingAddBooksToListScreen = true
    }
}
