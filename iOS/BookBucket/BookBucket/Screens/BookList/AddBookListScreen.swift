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
    
    @State private var title: String = ""
    @State private var isFavorite: Bool = false
    @State private var color: String = "Blue"
    @State private var isShowingError: Bool = false
    @State private var isShowingRequirementsPopover: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("Title of Book List", text: $title)
                    
                    FieldInfoPopoverToggleButton(label: "Show book list title field requirements", action: toggleRequirementsPopover)
                        .popover(isPresented: $isShowingRequirementsPopover) {
                            FieldInfoPopover(infoText: "The book list title field must not be empty.")
                        }
                }
                
                Toggle("Is Favorite Book List", isOn: $isFavorite)
                
                Section("Choose a Color") {
                    BookListColorPicker(selection: $color)
                }
            }
            .navigationTitle(Text("Add Book List"))
            .alert(isPresented: $isShowingError) {
                Alert(title: Text("Failed to Create Book List"), message: Text("Something went wrong when trying to save the data you entered for a new book list. Please try again later."))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create", action: create)
                        .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func toggleRequirementsPopover() {
        isShowingRequirementsPopover.toggle()
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func create() {
        let bookList = BookList(title: title, color: color, isFavorite: isFavorite, books: [])
        let dataHelper = DataHelper()
        let result = dataHelper.insert(context: context, model: bookList)
        
        switch result {
        case .success(()):
            dismiss()
            
            return
        case .failure(_):
            if context.hasChanges {
                context.rollback()
            }
            
            isShowingError = true
        }
    }
}
