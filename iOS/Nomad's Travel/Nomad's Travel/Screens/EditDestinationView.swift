//
//  EditDestinationView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/28/25.
//

import SwiftUI

struct EditDestinationView: View {
	@Environment(\.modelContext) var context
	@Environment(\.dismiss) var dismiss
	
	@State private var destinationData: DestinationFormData

	@FocusState private var focusedCoordinateField: CoordinateField?

	var destination: Destination

	init(destination: Destination) {
		self.destination = destination
		self._destinationData = State(wrappedValue: DestinationFormData(destination: destination))
	}
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Name", text: $destinationData.name)
					TextField("Location", text: $destinationData.location)
					
					TextField("Latitude Coordinate", text: $destinationData.latitude)
						.accessibilityLabel(Text("Latitude Coordinate"))
						.focused($focusedCoordinateField, equals: CoordinateField.latitude)
						.keyboardType(.decimalPad)
					
					TextField("Longitude Coordinate", text: $destinationData.longitude)
						.accessibilityLabel(Text("Longitude Coordinate"))
						.focused($focusedCoordinateField, equals: CoordinateField.longitude)
						.keyboardType(.decimalPad)
				} footer: {
					Text("Latitude and longitude fields are both optional. Both must be populated or empty. When Populated, only numbers with optional decimal points and negative signs are allowed.")
				}
				
				Section {
					DestinationPriorityPickerView(selection: $destinationData.priority, style: .defaultPicker, exclude: [ .all ])
					Toggle("Visited", isOn: $destinationData.visited)
				}
				
				Section {
					DestinationPhotoPicker(selection: $destinationData.image)
				}
			}
			.navigationTitle(Text("Edit Destination"))
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
						destinationData.save(context: context)
						dismiss()
					}
					.disabled(!destinationData.isValidDestination())
				}
			}
			.alert(Constants.updateDestinationErrorTitle, isPresented: $destinationData.isShowingSaveError) {
				Button("OK") {
					destinationData.isShowingSaveError = false
				}
			} message: {
				Text(Constants.updateDestinationErrorMessage)
			}
		}
	}
}
