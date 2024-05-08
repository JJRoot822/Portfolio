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
    @State private var isShowingRequirementsPopover: Bool = false
    @State private var isShowingError: Bool = false
    
    private let filters: PHPickerFilter = .any(of: [
        .images,
            .not(.bursts),
            .not(.cinematicVideos), 
            .not(.depthEffectPhotos), 
            .not(.livePhotos), 
            .not(.panoramas),
            .not(.screenRecordings),
            .not(.screenshots),
            .not(.slomoVideos),
            .not(.timelapseVideos),
            .not(.videos)
    ])

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                selectedImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                PhotosPicker(selection: $selectedItem, 
                             matching: filters) {
                    Label("Choose a Picture", systemImage: "camera.fill")
                }
                
                Button(action: toggleRequirementsPopover) {
                    Label("Show requirements for the book cover image field", systemImage: "info.circle")
                        .labelStyle(.iconOnly)
                }
            }
            
            Button("Clear Selection", action: clearCoverImage)
                .frame(width: .infinity)
                .buttonStyle(BorderedButtonStyle())
        }
        .popover(isPresented: $isShowingRequirementsPopover) {
            VStack {
                
                Text("The book cover image is optional.")
                
                HStack {
                    Spacer()
                    
                    Button("Close", action: toggleRequirementsPopover)
                }
            }
            .padding()
        }
        .alert(isPresented: $isShowingError) {
            Alert(title: Text("Failed to Load Image"), message: Text("Something went wrong when trying to load the photo you selected. Either it's in an unsupported format, or there is some unknown issue. Please try again later."))
        }
        .onChange(of: selectedItem) {
            Task {
                if let loadedData = try? await selectedItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: loadedData) {
                        selectedImage = Image(uiImage: uiImage)
                    } else {
                        isShowingError = true
                        
                        selectedImage = Image(systemName: "camera.slash")
                    }
                }
            }
        }
    }
    
    private func clearCoverImage() {
        selectedItem = nil
        selection = nil
        selectedImage = nil
    }
    
    private func toggleRequirementsPopover() {
        isShowingRequirementsPopover.toggle()
    }
}
