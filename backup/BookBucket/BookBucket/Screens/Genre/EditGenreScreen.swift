//
//  EditGenreScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/26/24.
//

import SwiftUI
import SwiftData

struct EditGenreScreen: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    @Bindable var genre: Genre
    
    @State private var isShowingError: Bool = false
    @State private var isShowingRequirementsPopover: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("name of Genre", text: $genre.name)
                    
                    Button(action: toggleRequirementsPopover) {
                        Label("Show genre name field requirements", systemImage: "info.circle")
                    }
                    .popover(isPresented: $isShowingRequirementsPopover) {
                        Text("The genre name field must not be empty.")
                            .padding()
                    }
                }
            }
            .navigationTitle(Text("Edit Genre"))
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
