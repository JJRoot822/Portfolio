//
//  RecognizedTextView.swift
//  DocuScan
//
//  Created by Joshua Root on 5/17/25.
//

import SwiftUI
import Vision

struct RecognizedTextView: View {
	@State private var text: String
	
	init(recognizedTexts: [RecognizedText]) {
		var text = ""
		
		for recognizedText in recognizedTexts {
			text.append(recognizedText.string)
			text.append(" ")
		}
		
		self._text = State(wrappedValue: text)
	}
	
	var body: some View {
		TextEditor(text: $text)
			.accessibilityLabel(Text("Recognized Text"))
	}
}
