//
//  BookCoverImagePicker.swift
//  BookBucket
//
//  Created by Joshua Root on 3/20/24.
//

import SwiftUI
import PhotosUI

struct BookCoverImagePicker: View {
    @Binding var selection: Data?
    
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    @State private var isShowingFailedPickingPhotoAlert: Bool = false
    @State private var isShowingRequirementsPopover: Bool = false
    
    var body: some View {
        HStack {
            selectedImage?
                .resizable()
                .scaledToFit()
                .frame(width: 75, height: 75)
            
            PhotosPicker("Select a Book Cover", 
                         selection: $selectedItem, 
                         matching: .any(of: [
                            .images,
                            .not(.depthEffectPhotos),
                            .not(.bursts),
                            .not(.livePhotos),
                            .not(.panoramas),
                            .not(.screenshots)
                         ])
            )
            
            Button(action: clearSelection) {
                Label("Clear Book Cover Selection", systemImage: "multiply")
                    .labelStyle(.iconOnly)
                
                Button(action: toggleRequirementsPopover) {
                    Label("Show Book Cover Field Requirements", systemImage: "info.circle")
                        .labelStyle(.iconOnly))
                }
                .popover(isPresented: $isShowingRequirements Popover) {
                    VStack {
                        Text("The cover for the book is optional.")
                        
                        HStack {
                            Spacer()
                            
                            Button("Close", action: toggleRequirementsPopover()
                        }
                    }
                                .padding()
                }
            }
        }
        .alert(isPresented: $isShowingFailedPickingPhotoAlert) {
            Alert(title: Text("Can't select photo"), 
                  message: Text("Something went wrong when selecting a photo. Please try again later."), 
                  dismissButton: .default(Text("Ok")))
        }
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self) {
                    let uiImage = UIImage(data: data)!
                    
                    self.selection = data
                    self.selectedImage = Image(uiImage: uiImage)
                    
                                } else {
                                    self.isShowingFailedPickingPhotoAlert = true
                                }
            }
        }
        
    }
    
    private func toggleRequirementsPopover() {
        isShowingRequirementsPopover.toggle()
    }
    
    func clearSelection() {
        self.selectedItem = nil
        self.selectedImage = nil
    }
}
