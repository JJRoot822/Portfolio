//
//  TagColorPicker.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/6/25.
//

import SwiftUI

struct TagColorPicker: View {
	let colors = TagColors.all
	
	@Binding var selection: String
	
	var body: some View {
		HStack(spacing: 10) {
			Color(selection)
				.frame(width: 75, height: 75)
				.clipShape(Circle())
		
			Picker("Tag Color", selection: $selection) {
				ForEach(colors, id: \.id) { tagColor in
					Text(tagColor.name).tag(tagColor.resourceName)
				}
			}
			.pickerStyle(.automatic)
		}
	}
}
