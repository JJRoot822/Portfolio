//
//  EditBookListScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/1/24.
//

import SwiftUI
import SwiftData

struct EditBookListScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @Bindable var bookList: BookList
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("Title of Book List", text: $bookList.title)
                    
                    FieldInfoPopoverToggleButton(label: "Show book list title field requirements", action: viewModel.toggleRequirementsPopover)
                        .popover(isPresented: $viewModel.isShowingRequirementsPopover) {
                            FieldInfoPopover(infoText: "The book list title field must not be empty.")
                        }
                }
                
                Toggle("Is Favorite Book List", isOn: $bookList.isFavorite)
                
                Section("Choose a Color") {
                    BookListColorPicker(selection: $bookList.color)
                }
            }
            .navigationTitle(Text("Edit Book List"))
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(title: Text("Failed to Save Changes"), message: Text("Something whent wrong when trying to save the changes you made to the book list. Please try again later."))
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
                    .disabled(bookList.title.isEmpty)
                }
            }
            .onChange(of: viewModel.shouldDismiss) {
                if viewModel.shouldDismiss {
                    dismiss()
                }
            }
        }
    }
}
