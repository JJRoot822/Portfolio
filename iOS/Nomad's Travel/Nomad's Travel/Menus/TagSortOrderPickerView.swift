//
//  TagSortOrderPickerView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/6/25.
//

import SwiftUI

struct TagSortOrderPickerView: View {
	@Binding var selection: TagSortOrder
	
	var body: some View {
		Menu {
			ForEach(TagSortOrder.allCases, id: \.rawValue) { option in
				if selection == option {
					Button {
						selection = option
					} label: {
						Label(option.rawValue, systemImage: "checkmark")
					}
				} else {
					Button(option.rawValue) {
						selection = option
					}
				}
			}
		} label: {
			Label("Sort Tags", systemImage: "arrow.up.arrow.down")
		}
		.labelStyle(.iconOnly)
	}
}

