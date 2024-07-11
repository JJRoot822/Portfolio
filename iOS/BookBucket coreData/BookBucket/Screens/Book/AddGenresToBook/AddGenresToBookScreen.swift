//
//  AddGenresToBookScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI
import SwiftData

struct AddGenresToBookScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var book: Book
    
    @Query private var genres: [Genre]
    
    @State private var viewModel = ViewModel()
    var body: some View {
        NavigationStack {
            List(selection: $viewModel.selectedGenres) {
                ForEach(genres) { genre in
                    if !book.genres.contains(genre) {
                        Text(genre.name)
                            .tag(genre)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    EditButton()
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: viewModel.cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        viewModel.addGenresToBook(context: context, book: book)
                    }
                }
            }
            .navigationTitle(Text("Add Genres"))
        }
        .alert(isPresented: $viewModel.isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when you tried to add genres to \(book.title). Please try again later."), dismissButton: .default(Text("Ok")))
        }
        .onChange(of: viewModel.shouldDismiss) {
            if viewModel.shouldDismiss {
                dismiss()
            }
        }
    }
}
