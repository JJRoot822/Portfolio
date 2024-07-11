//
//  AddBookListScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/30/24.
//

import SwiftUI
import SwiftData

struct AddBookListScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("Title of Book List", text: $viewModel.title)
                }
                
                Toggle("Is Favorite Book List", isOn: $viewModel.isFavorite)
                
                Section("Choose a Color") {
                    BookListColorPicker(selection: $viewModel.color)
                }
            }
            .navigationTitle(Text("Add Book List"))
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(title: Text("Failed to Create Book List"), message: Text("Something went wrong when trying to save the data you entered for a new book list. Please try again later."))
            }
            .onChange(of: viewModel.shouldDismiss) {
                if viewModel.shouldDismiss {
                    dismiss()
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: viewModel.cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        viewModel.create(context: context)
                    }
                    .disabled(viewModel.title.isEmpty)
                }
            }
        }
    }
}
