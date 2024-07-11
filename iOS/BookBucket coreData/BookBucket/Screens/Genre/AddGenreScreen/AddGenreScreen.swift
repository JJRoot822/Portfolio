//
//  AddGenreScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/26/24.
//

import SwiftUI
import SwiftData

struct AddGenreScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss

    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("name of Genre", text: $viewModel.genreName)
                }
                
                Toggle("Is Favorite Genre", isOn: $viewModel.isFavorite)
            }
            .navigationTitle(Text("Add Genre"))
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(title: Text("Failed to Create Genre"), message: Text("Something went wrong when trying to save the data you entered for a new genre. Please try again later."), dismissButton: .cancel(Text("Ok")))
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
                    .disabled(viewModel.genreName.isEmpty)
                }
            }
        }
        .interactiveDismissDisabled()
    }
}
