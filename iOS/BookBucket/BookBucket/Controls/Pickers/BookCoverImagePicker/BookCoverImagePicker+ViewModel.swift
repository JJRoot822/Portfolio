//
//  BookCoverImagePicker+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/14/24.
//

import SwiftUI
import PhotosUI

extension BookCoverImagePicker {
    @Observable
    class ViewModel {
        var shouldClear: Bool = false
        var selectedItem: PhotosPickerItem?
        var selectedImage: Image?
        var isShowingError: Bool = false
        
        let filters: PHPickerFilter = .any(of: [
            .images,
                .not(.bursts),
                .not(.cinematicVideos),
                .not(.depthEffectPhotos),
                .not(.livePhotos),
                .not(.screenRecordings),
                .not(.slomoVideos),
                .not(.timelapseVideos),
                .not(.videos)
        ])

        func clearCoverImage() {
            shouldClear = true
            selectedItem = nil
            selectedImage = nil
        }
        
        func loadImageData() async {
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
