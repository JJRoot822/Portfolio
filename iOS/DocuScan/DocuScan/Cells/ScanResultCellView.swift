//
//  ScanResultCellView.swift
//  DocuScan
//
//  Created by Joshua Root on 4/17/25.
//

import SwiftUI

struct ScanResultCellView: View {
	var result: TextRecognitionResult
	
	var body: some View {
		VStack {
			Image(uiImage: result.image)
				.resizable()
				.scaledToFit()
				.frame(width: 125, height: 125)
			
			Spacer()
			
			Text("Page \(result.pageNumber)")
				.font(.body)
				.multilineTextAlignment(.center)
				.lineLimit(3, reservesSpace: true)
				.truncationMode(.tail)
		}
		.accessibilityElement()
		.accessibilityLabel(Text("Page \(result.pageNumber)"))
		.accessibilityAddTraits(.isButton)
	}
}
