//
//  AddAuthorScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/25/24.
//

import SwiftUI
import SwiftData

struct AddAuthorScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("name of Author", text: $viewModel.authorName)
                
                    FieldInfoPopoverToggleButton(label: "Show author name field requirements", action: viewModel.toggleRequirementsPopover)
                        .popover(isPresented: $viewModel.isShowingRequirementsPopover) {
                            FieldInfoPopover(infoText: "The author name field must not be empty.")
                        }
                }
                
                Toggle("Is Favorite Author", isOn: $viewModel.isFavorite)
            }
            .navigationTitle(Text("Add Author"))
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(title: Text("Failed to Create Author"), message: Text("Something went wrong when trying to save the data you entered for a new author. Please try again later."), dismissButton: .cancel(Text("Ok")))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: viewModel.cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create") {
                        viewModel.create(context: context)
                    }
                    .disabled(viewModel.authorName.isEmpty)
                }
            }
        }
        .onChange(of: viewModel.shouldDismiss) {
            if viewModel.shouldDismiss {
                dismiss()
            }
        }
    }
}
