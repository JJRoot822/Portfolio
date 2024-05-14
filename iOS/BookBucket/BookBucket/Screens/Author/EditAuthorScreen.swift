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
    
    @State private var isShowingError: Bool = false
    @State private var isShowingRequirementsPopover: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("name of Author", text: $author.name)
                    
                    FieldInfoPopoverToggleButton(label: "Show author name field requirements", action: toggleRequirementsPopover)
                        .popover(isPresented: $isShowingRequirementsPopover) {
                            FieldInfoPopover(infoText: "The author name field must not be empty.")
                        }
                }
                
                Toggle("Is Favorite Author", isOn: $author.isFavorited)
            }
            .navigationTitle(Text("Edit Author"))
            .alert(isPresented: $isShowingError) {
                Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to the author's information. Please try again later."), dismissButton: .cancel(Text("Ok")))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: saveChanges)
                        .disabled(author.name.isEmpty)
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
