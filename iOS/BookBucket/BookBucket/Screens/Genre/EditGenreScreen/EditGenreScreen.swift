//
//  EditGenreScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/26/24.
//

import SwiftUI
import SwiftData

struct EditGenreScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    
    @Bindable var genre: Genre
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("Genre Name", text: $genre.name)
                    
                    FieldInfoPopoverToggleButton(label: "Show genre name field requirements", action: viewModel.toggleRequirementsPopover)
                }
                .popover(isPresented: $viewModel.isShowingRequirementsPopover) {
                    FieldInfoPopover(infoText: "The genre name field must not be empty")
                }
                
                Toggle("Favorite Genre", isOn: $genre.isFavorite)
            }
            .onChange(of: viewModel.shouldDismiss) {
                if viewModel.shouldDismiss {
                    dismiss()
                }
            }
            .navigationTitle(Text("Edit Genre"))
            .navigationBarTitleDisplayMode(.large)
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to the genre's information. Please try again later."), dismissButton: .cancel(Text("Ok")))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        viewModel.cancel(context: context)
                    }
                }
                        
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveChanges(context: context)
                    }
                    .disabled(genre.name.isEmpty)
                }
            }
        }
        .interactiveDismissDisabled()
    }
}
