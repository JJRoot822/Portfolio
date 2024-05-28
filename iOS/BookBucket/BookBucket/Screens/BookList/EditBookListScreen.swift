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
    
    @State private var isShowingError: Bool = false
    @State private var isShowingRequirementsPopover: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("Title of Book List", text: $bookList.title)
                    
                    FieldInfoPopoverToggleButton(label: "Show book list title field requirements", action: toggleRequirementsPopover)
                        .popover(isPresented: $isShowingRequirementsPopover) {
                            FieldInfoPopover(infoText: "The book list title field must not be empty.")
                        }
                }
                
                Toggle("Is Favorite Book List", isOn: $bookList.isFavorite)
                
                Section("Choose a Color") {
                    BookListColorPicker(selection: $bookList.color)
                }
            }
            .navigationTitle(Text("Edit Book List"))
            .alert(isPresented: $isShowingError) {
                Alert(title: Text("Failed to Save Changes"), message: Text("Something whent wrong when trying to save the changes you made to the book list. Please try again later."))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: saveChanges)
                        .disabled(bookList.title.isEmpty)
                }
            }
        }
    }
    
    private func toggleRequirementsPopover() {
        isShowingRequirementsPopover.toggle()
    }
    
    private func cancel() {
        if context.hasChanges {
            context.rollback()
        }
        
        dismiss()
    }
    
    private func saveChanges() {
        let dataHelper = DataHelper()
        let result = dataHelper.save(context: context)
        
        switch result {
        case .success(()):
            return
        case .failure(_):
            if context.hasChanges {
                context.rollback()
            }
            
            isShowingError = true
        }
    }
}
