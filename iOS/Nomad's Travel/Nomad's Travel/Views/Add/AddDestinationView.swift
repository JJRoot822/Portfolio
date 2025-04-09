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
	
	@State private var destinationData: DestinationFormData = DestinationFormData()

	@FocusState private var focusedField: DestinationField?

	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Name", text: $destinationData.name)
						.focused($focusedField, equals: DestinationField.name)
						.accessibilityLabel(Text(destinationData.name.isEmpty ? "" : "Name"))

					TextField("Street Address", text: $destinationData.streetAddress)
						.focused($focusedField, equals: DestinationField.address)
						.accessibilityLabel(Text(destinationData.streetAddress.isEmpty ? "" : "Street Address"))
					TextField("City", text: $destinationData.city)
						.focused($focusedField, equals: DestinationField.city)
						.accessibilityLabel(Text(destinationData.city.isEmpty ? "" : "City"))
					
					Picker("State", selection: $destinationData.state) {
						Text("None").tag("None")
						
						ForEach(Constants.states, id: \.abbreviation) { state in
							Text("\(state.abbreviation) - \(state.name)").tag(state.name)
						}
					}
					
					TextField("Country", text: $destinationData.country)
						.focused($focusedField, equals: DestinationField.country)
						.accessibilityLabel(Text(destinationData.country.isEmpty ? "" : "Country"))
					
					TextField("Zip Code", text: $destinationData.zipCode)
						.focused($focusedField, equals: DestinationField.zipCode)
						.keyboardType(.numberPad)
						.accessibilityLabel(Text(destinationData.zipCode.isEmpty ? "" : "Zip Code"))
				}
				
				Section {
					DestinationPriorityPickerView(selection: $destinationData.priority, style: .defaultPicker, exclude: [ .all ])
					Toggle("Visited", isOn: $destinationData.visited)
				}
				
				Section {
					DestinationPhotoPicker(selection: $destinationData.image)
				}
				
				Section {
					TextField("Additional Notes", text: $destinationData.notes, axis: .vertical)
						.focused($focusedField, equals: DestinationField.notes )
						.accessibilityLabel(Text(destinationData.notes.isEmpty ? "" : "Additional Notes"))
				}
			}
			.navigationTitle(Text("Add Destination"))
			.navigationBarTitleDisplayMode(.inline)
			.toolbar {
				if focusedField != nil {
					ToolbarItem(placement: .keyboard) {
						HStack {
							Spacer()
							
							Button("Done") {
								focusedField = nil
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
			.onChange(of: destinationData.shouldDismiss) {
				if destinationData.shouldDismiss {
					dismiss()
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
