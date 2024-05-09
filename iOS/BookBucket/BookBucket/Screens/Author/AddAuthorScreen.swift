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
    
    @State private var authorName: String = ""
    @State private var isFavorite: Bool = false
    @State private var isShowingError: Bool = false
    @State private var isShowingRequirementsPopover: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                HStack(spacing: 10) {
                    TextField("name of Author", text: $authorName)
                
                    Button(action: toggleRequirementsPopover) {
                        Label("Show author name field requirements", systemImage: "info.circle")
                    }
                    .popover(isPresented: $isShowingRequirementsPopover) {
                        VStack {
                            Text("The author name field must not be empty.")
                         
                            HStack {
                                Spacer()
                                
                                Button("Close", action: toggleRequirementsPopover)
                            }
                        }
                        .padding()
                    }
                }
                
                Toggle("Is Favorite Author", isOn: $isFavorite)
            }
            .navigationTitle(Text("Add Author"))
            .alert(isPresented: $isShowingError) {
                Alert(title: Text("Failed to Create Author"), message: Text("Something went wrong when trying to save the data you entered for a new author. Please try again later."), dismissButton: .cancel(Text("Ok")))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel, action: cancel)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Create", action: create)
                        .disabled(authorName.isEmpty)
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
        let author = Author(name: authorName, isFavorited: isFavorite, books: [])
        let dataHelper = DataHelper()
        let result = dataHelper.insert(context: context, model: author)
        
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
