//
//  EditAuthorScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/25/24.
//

import SwiftUI
import SwiftData

struct EditAuthorScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @Bindable var author: Author
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("name of Author", text: $author.name)
                    
                    FieldInfoPopoverToggleButton(label: "Show author name field requirements", action: viewModel.toggleRequirementsPopover)
                        .popover(isPresented: $viewModel.isShowingRequirementsPopover) {
                            FieldInfoPopover(infoText: "The author name field must not be empty.")
                        }
                }
                
                Toggle("Is Favorite Author", isOn: $author.isFavorited)
            }
            .navigationTitle(Text("Edit Author"))
            .onChange(of: viewModel.shouldDismiss) {
                if viewModel.shouldDismiss {
                    dismiss()
                }
            }
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to the author's information. Please try again later."), dismissButton: .cancel(Text("Ok")))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        viewModel.cancel(context: context)
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveChanges(context: context )
                    }
                    .disabled(author.name.isEmpty)
                }
            }
        }
    }
}
