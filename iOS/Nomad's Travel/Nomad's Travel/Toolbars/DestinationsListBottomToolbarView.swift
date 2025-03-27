//
//  DestinationsListBottomToolbarView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI

struct DestinationsListBottomToolbarView: View {
	@Binding var selectedPriority: DestinationPriority
	@Binding var selectedSort: DestinationSortOrder
	@Binding var selectedFilter: DestinationFilter
	
	
	var body: some View {
		HStack {
			DestinationFilterPickerView(selection: $selectedFilter)
			
			Spacer()
			
			DestinationPriorityPickerView(selection: $selectedPriority, style: .defaultPicker)
		
			Spacer()
			
			DestinationSortOrderPickerView(selection: $selectedSort)
		}
	}
}
