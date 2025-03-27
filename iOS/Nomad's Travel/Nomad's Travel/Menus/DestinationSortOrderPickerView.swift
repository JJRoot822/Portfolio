//
//  DestinationSortOrderPickerView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI

struct DestinationSortOrderPickerView: View {
	@Binding var selection: DestinationSortOrder
	
	var body: some View {
		Menu {
			ForEach(DestinationSortOrder.allCases, id: \.rawValue) { option in
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
			Label("Sort Destinations", systemImage: "arrow.up.arrow.down")
		}
		.labelStyle(.iconOnly)
	}
}
