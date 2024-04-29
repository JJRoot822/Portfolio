//
//  GenreCell.swift
//  BookBucket
//
//  Created by Joshua Root on 4/26/24.
//

import SwiftUI
import SwiftData

struct GenreCell: View {
    @Environment(\.modelContext) var context
    
    @State private var showingEditSheet: Bool = false
    @State private var isDeleteRequested: Bool = false
    @State private var isShowingError: Bool = false
    
    @Bindable var genre: Genre
    
    var body: some View {
        BasicListCell(title: genre.name, subtitle: LocalizedStringKey(stringInterpolation: "\(genre.books) Books"), boldTitle: false)
            .padding()
            .accessibilityElement(children: .combine)
            .confirmationDialog("Are you sure you want to delete this author?", isPresented: $isDeleteRequested) {
                Button("Delete", role: .destructive, action: deleteGenre)
            }
            .alert(isPresented: $isShowingError) {
                Alert(title: Text("Failed to Delete Genre"), message: Text("Something went wrong when trying to delete the genre you requested. Please try again later."))
            }
            .sheet(isPresented: $showingEditSheet) {
                EditGenreScreen(genre: genre)
            }
            .contextMenu {
                IconButton(title: "Edit Author", icon: "pencil", action: toggleEditSheet)
                IconButton(title: "Delete", icon: "trash", action: requestDelete)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                IconButton(title: "Edit Author", icon: "pencil", action: toggleEditSheet)
                IconButton(title: "Delete", icon: "trash", action: requestDelete)
            }
    }
    
    private func toggleEditSheet() {
        self.showingEditSheet = true
    }
    
    private func deleteGenre() {
        let dataHelper = DataHelper()
        let result = dataHelper.delete(context: context, model: genre)
        
        switch result {
        case .success(()):
            return
        case .failure(_):
            self.isShowingError = true
        }
    }
    
    private func requestDelete() {
        self.isDeleteRequested = true
    }
}
