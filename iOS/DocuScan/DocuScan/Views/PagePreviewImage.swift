//
//  PagePreviewImage.swift
//  DocuScan
//
//  Created by Joshua Root on 5/17/25.
//

import SwiftUI

struct PagePreviewImage: View {
	var image: UIImage
	
	var body: some View {
		GeometryReader { proxy in
			Image(uiImage: image)
				.resizable()
				.frame(width: proxy.size.width, height: proxy.size.height)
				.scaledToFit()
		}
	}
}
