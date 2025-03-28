//
//  DestinationPhotoPicker.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/27/25.
//

import SwiftUI
import PhotosUI

struct DestinationPhotoPicker: View {
	@Binding var selection: UIImage?
	
	@State private var selectedItem: PhotosPickerItem?
	
	var thumbnail: some View {
		if let image = selection {
			Image(uiImage: image)
				.resizable()
				.scaledToFit()
				.frame(width: 50, height: 50)
				.clipShape(Circle())
		} else {
			Image(systemName: "camera")
				.resizable()
				.scaledToFit()
				.frame(width: 50, height: 50)
				.clipShape(Circle())
		}
	}
	
	var body: some View {
		HStack {
			PhotosPicker(selection: $selectedItem, matching: .any(of: [ .images, .not(.screenshots) ])) {
				HStack {
					thumbnail
					
					if selectedItem != nil {
						Text("Photo Selected")
					} else {
						Text("No Selection")
					}
				}
			}
		
			if selectedItem != nil {
				Button {
					selectedItem = nil
				} label: {
					Label("Clear Selection", systemImage: "multiply")
				}
				.labelStyle(.iconOnly)
			}
		}
		.onChange(of: selectedItem, loadImage)
	}
	
	private func loadImage() {
		Task {
			guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
			guard let inputImage = UIImage(data: imageData) else { return }
			
			selection = inputImage
		}
	}
}
