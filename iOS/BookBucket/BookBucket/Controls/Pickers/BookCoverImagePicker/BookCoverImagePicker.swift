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
    
    @State private var viewModel = ViewModel()

    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                viewModel.selectedImage?
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .accessibilityHidden(true)
                
                PhotosPicker(selection: $viewModel.selectedItem,
                             matching: viewModel.filters) {
                    Label("Choose a Picture", systemImage: "camera.fill")
                }
            }
            
            Button("Clear Selection", action: viewModel.clearCoverImage)
                .buttonStyle(BorderedButtonStyle())
        }
        .alert(isPresented: $viewModel.isShowingError) {
            Alert(title: Text("Failed to Load Image"), message: Text("Something went wrong when trying to load the photo you selected. Either it's in an unsupported format, or there is some unknown issue. Please try again later."))
        }
        .onChange(of: viewModel.shouldClear) {
            if viewModel.shouldClear {
                selection = nil
            }
        }
        .onChange(of: viewModel.selectedItem) {
            Task {
                await viewModel.loadImageData()
            }
        }
    }
    
    
}
