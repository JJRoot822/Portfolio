//
//  DestinationFilterPickerView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI

struct DestinationFilterPickerView: View {
	@Binding var selection: DestinationFilter
	
	var body: some View {
		Menu {
			ForEach(DestinationFilter.allCases, id: \.rawValue) { option in
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
			Label("Filter Destinations", systemImage: "line.3.horizontal.decrease")
		}
		.labelStyle(.iconOnly)
	}
}
