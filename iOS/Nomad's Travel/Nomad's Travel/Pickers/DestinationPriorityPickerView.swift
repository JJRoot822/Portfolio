//
//  DestinationPriorityPickerView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI

struct DestinationPriorityPickerView: View {
	@Binding var selection: DestinationPriority
	
	var style: DestinationPriorityPickerStyle
	var exclude: [DestinationPriority] = []
	
	var defaultPicker: some View {
		Picker("Priority", selection: $selection) {
			ForEach(DestinationPriority.allCases, id: \.rawValue) { priority in
				if !exclude.contains(priority) {
					Text(priority.rawValue).tag(priority)
				}
			}
		}
		.labelStyle(.titleOnly)
	}
	
	var segmentedPicker: some View {
		Picker("Priority", selection: $selection) {
			ForEach(DestinationPriority.allCases, id: \.rawValue) { priority in
				if !exclude.contains(priority) {
					Text(priority.rawValue).tag(priority)
				}
			}
		}
		.pickerStyle(.segmented)
		.labelsHidden()
	}
	
	var menuPicker: some View {
		Menu {
			ForEach(DestinationPriority.allCases, id: \.rawValue) { priority in
				if !exclude.contains(priority) {
					if selection == priority {
						Button {
							selection = priority
						} label: {
							Label(priority.rawValue, systemImage: "checkmark")
						}
					} else {
						Button(priority.rawValue) {
							selection = priority
						}
					}
				}
			}
		} label: {
			Label("Priority", systemImage: "flag")
		}
		.labelStyle(.iconOnly)
	}
	
	var body: some View {
		if style == .defaultPicker {
			defaultPicker
		} else if style == .segmented {
			segmentedPicker
		} else {
			menuPicker
		}
	}
}
