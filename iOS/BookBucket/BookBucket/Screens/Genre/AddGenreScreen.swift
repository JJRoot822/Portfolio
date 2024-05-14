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
    
    @State private var genreName: String = ""
    @State private var isFavorite: Bool = false
    @State private var isShowingError: Bool = false
    @State private var isShowingRequirementsPopover: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("name of Genre", text: $genreName)
                
                    FieldInfoPopoverToggleButton(label: "Show genre name field requirements", action: toggleRequirementsPopover)
                        .popover(isPresented: $isShowingRequirementsPopover) {
                            FieldInfoPopover(infoText: "The genre name field must not be empty.")
                        }
                }
                
                Toggle("Is Favorite Genre", isOn: $isFavorite)
            }
            .navigationTitle(Text("Add Genre"))
            .alert(isPresented: $isShowingError) {
                Alert(title: Text("Failed to Create Genre"), message: Text("Something went wrong when trying to save the data you entered for a new genre. Please try again later."), dismissButton: .cancel(Text("Ok")))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create", action: create)
                        .disabled(genreName.isEmpty)
                }
            }
        }
        .interactiveDismissDisabled()
    }
    
    private func toggleRequirementsPopover() {
        isShowingRequirementsPopover.toggle()
    }
    
    private func cancel() {
        dismiss()
    }
    
    private func create() {
        let genre = Genre(name: genreName, isFavorite: isFavorite, books: [])
        let dataHelper = DataHelper()
        let result = dataHelper.insert(context: context, model: genre)
        
        switch result {
        case .success(()):
            dismiss()
            return
        case .failure(_):
            context.rollback()
            isShowingError = true
        }
    }
}
