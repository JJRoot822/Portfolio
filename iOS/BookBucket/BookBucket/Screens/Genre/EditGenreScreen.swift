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
    
    @State private var isShowingRequirementsPopover: Bool = false
    @State private var isShowingError: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("Genre Name", text: $genre.name)
                    
                    FieldInfoPopoverToggleButton(label: "Show genre name field requirements", action: toggleRequirementsPopover)
                }
                .popover(isPresented: $isShowingRequirementsPopover) {
                    FieldInfoPopover(infoText: "The genre name field must not be empty")
                }
                
                Toggle("Favorite Genre", isOn: $genre.isFavorite)
            }
            .navigationTitle(Text("Edit Genre"))
            .navigationBarTitleDisplayMode(.large)
            .alert(isPresented: $isShowingError) {
                Alert(title: Text("Failed to Save Changes"), message: Text("Something went wrong when trying to save the changes you made to the genre's information. Please try again later."), dismissButton: .cancel(Text("Ok")))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancel)
                }
                        
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: saveChanges)
                        .disabled(genre.name.isEmpty)
                }
            }
        }
        .interactiveDismissDisabled()
    }
    
    private func cancel() {
        if context.hasChanges {
            context.rollback()
        }
        
        dismiss()
    }
    
    private func toggleRequirementsPopover() {
        isShowingRequirementsPopover.toggle()
    }
    
    private func saveChanges() {
        let dataHelper = DataHelper()
        let result = dataHelper.save(context: context)
        
        switch result {
        case .success(()):
            dismiss()
            
            return
        case .failure(_):
            if context.hasChanges {
                context.rollback()
            }
        }
        
        self.isShowingError = true
    }
}
