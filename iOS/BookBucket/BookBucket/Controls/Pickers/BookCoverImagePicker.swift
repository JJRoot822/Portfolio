//
//  BookCoverImagePicker.swift
//  BookBucket
//
//  Created by Joshua Root on 6/15/24.
//

import SwiftUI
import PhotosUI

struct BookCoverImagePicker: View {
    @Binding var selection: Data?
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    let filter: PHPickerFilter = .any(of: [
        .not(.bursts), .not(.cinematicVideos), .not(.livePhotos),
        .not(.depthEffectPhotos), .not(.panoramas), .not(.screenRecordings),
        .not(.slomoVideos), .not(.videos), .not(.timelapseVideos),
            .images, .screenshots
    ])
    
    var body: some View {
        HStack {
            ZStack {
                if let selection = selection {
                    Image(uiImage: UIImage(data: selection)!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .accessibilityHidden(true)
                }
                
                PhotosPicker(selection: $selectedItem, matching: filter, preferredItemEncoding: .compatible) {
                    Label("Choose a Book Cover", systemImage: "camera.fill")
                        .labelStyle(.iconOnly)
                }
                .frame(width: 50, height: 50)
            }
            
            Text(selection == nil ? "No Book Cover Image Selected" : "Book Cover Image Selected")
        }
        .onChange(of: selectedItem) {
            Task {
                if let loaded = try? await selectedItem?.loadTransferable(type: Data.self) {
                    selection = loaded
                } else {
                    print("Failed")
                }
            }
        }
    }
}
