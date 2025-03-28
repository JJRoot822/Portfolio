//
//  NumericField.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/27/25.
//

import SwiftUI

struct NumericField: View {
	var label: String
	
	@Binding var text: String
	
	init(_ label: String, text: Binding<String>) {
		self.label = label
		self._text = text
	}
	
	var body: some View {
		TextField(label, text: $text)
			.onChange(of: text, filter)
	}
	
	private func filter() {
		let decimalsCount = text.count { $0 == "." }
		
		guard decimalsCount > 1 else { return }
		
		var foundDecimals = 0
		var result = ""
		
		for character in text {
			if character.isNumber {
				result += String(character)
			}
			
			if character == "." && foundDecimals < 1 {
				foundDecimals += 1
				result += String(character)
			}
		}
		
		text = result
	}
}
