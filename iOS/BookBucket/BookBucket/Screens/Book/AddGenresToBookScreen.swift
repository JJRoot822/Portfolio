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
    
    var book: Book
    
    @Query private var genres: [Genre]
    
    @State private var selectedGenres = Set<Genre>()
    @State private var isShowingSaveError = false
    
    var body: some View {
        NavigationStack {
            List(selection: $selectedGenres) {
                ForEach(genres) { genre in
                    Text(genre.name)
                        .tag(genre)
                }
            }
            .toolbar {
                Button("Add", action: addGenresToBook)
            }
            .navigationTitle(Text("Add Genres"))
        }
        .alert(isPresented: $isShowingSaveError) {
            Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when you tried to add genres to \(book.title). Please try again later."), dismissButton: .default(Text("Ok")))
        }
    }
    
    private func addGenresToBook() {
        selectedGenres.forEach {
            book.genres.append($0)
        }
        
        do {
            try context.save()
        } catch {
            isShowingSaveError = true
        }
    }
}
