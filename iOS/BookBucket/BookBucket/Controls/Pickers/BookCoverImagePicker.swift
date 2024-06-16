//
//  BookCoverImagePicker.swift
//  BookBucket
//
//  Created by Joshua Root on 6/15/24.
//

import SwiftUI
import PhotosUI

struct BookCoverImagePicker: UIViewControllerRepresentable {
    @Binding var selection: Data?
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: BookCoverImagePicker
        
        init(_ parent: BookCoverImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    let img = image as? UIImage
                    self.parent.selection = img?.pngData()
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
}
