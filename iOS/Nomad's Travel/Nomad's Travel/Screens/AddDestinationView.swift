//
//  AddDestinationView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/27/25.
//

import SwiftUI

struct AddDestinationView: View {
	@Environment(\.modelContext) var context
	@Environment(\.dismiss) var dismiss
	
	@State private var destination: DestinationFormData = DestinationFormData()

	@FocusState private var focusedCoordinateField: CoordinateField?
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Name", text: $destination.name)
					TextField("Location", text: $destination.location)
					
					TextField("Latitude Coordinate", text: $destination.latitude)
						.accessibilityLabel(Text("Latitude Coordinate"))
						.focused($focusedCoordinateField, equals: CoordinateField.latitude)
						.keyboardType(.decimalPad)
					
					TextField("Longitude Coordinate", text: $destination.longitude)
						.accessibilityLabel(Text("Longitude Coordinate"))
						.focused($focusedCoordinateField, equals: CoordinateField.longitude)
						.keyboardType(.decimalPad)
				} footer: {
					Text("Latitude and longitude fields are both optional. Both must be populated or empty. When Populated, only numbers with optional decimal points and negative signs are allowed.")
				}
				
				Section {
					DestinationPriorityPickerView(selection: $destination.priority, style: .defaultPicker, exclude: [ .all ])
					Toggle("Visited", isOn: $destination.visited)
				}
				
				Section {
					DestinationPhotoPicker(selection: $destination.image)
				}
			}
			.navigationTitle(Text("Add Destination"))
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				if focusedCoordinateField != nil {
					ToolbarItem(placement: .keyboard) {
						HStack {
							Spacer()
							
							Button("Done") {
								focusedCoordinateField = nil
							}
						}
					}
				}
				
				ToolbarItem(placement: .cancellationAction) {
					Button("Cancel", role: .cancel) {
						dismiss()
					}
				}
				
				ToolbarItem(placement: .confirmationAction) {
					Button("Save") {
						destination.save(context: context)
						dismiss()
					}
					.disabled(!destination.isValidDestination())
				}
			}
			.alert("Failed to Save Destination", isPresented: $destination.isShowingSaveError) {
				Button("OK") {
					destination.isShowingSaveError = false
				}
			} message: {
				Text("Something went wrong when trying to save the destination data you entered. Please try again later.")
			}
		}
	}
}
