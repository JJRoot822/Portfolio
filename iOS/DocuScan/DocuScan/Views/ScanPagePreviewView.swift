//
//  ScanPagePreviewView.swift
//  DocuScan
//
//  Created by Joshua Root on 5/17/25.
//

import SwiftUI

struct ScanPagePreviewView: View {
	var result: TextRecognitionResult
	
	var body: some View {
		TabView {
			PagePreviewImage(image: result.image)
			RecognizedTextView(recognizedTexts: result.topCandidates())
		}
		.tabViewStyle(.page)
	}
}

