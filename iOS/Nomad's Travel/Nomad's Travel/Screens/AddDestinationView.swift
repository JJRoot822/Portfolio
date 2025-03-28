//
//  AddDestinationView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/27/25.
//

import SwiftUI
import SwiftData

@Observable
class DestinationFormData {
	var name: String = ""
	var location: String = ""
	var latitude: String = ""
	var longitude: String = ""
	var priority: DestinationPriority = .low
	var visited: Bool = false
	var image: UIImage? = nil
	var notes: String = ""
	
	var isShowingSaveError: Bool = false
	
	func isValidDestination() -> Bool {
		return DestinationValidator.isValidDestination(name: name, location: location, latitude: latitude, longitude: longitude)
	}
	
	func save(context: ModelContext) {
		let destination = Destination(
			name: name,
			location: location,
			latitude: Double(latitude)!,
			longitude: Double(longitude)!,
			priority: DestinationPriority.intValue(for: priority),
			visited: visited,
			image: image?.jpegData(compressionQuality: 0.1),
			notes: notes,
			tags: []
		)
		
		context.insert(destination)
		
		do {
			try context.save()
		} catch {
			isShowingSaveError = true
		}
	}
}

struct AddDestinationView: View {
	@Environment(\.modelContext) var context
	@Environment(\.dismiss) var dismiss
	
	@State private var destination: DestinationFormData = DestinationFormData()
	
	var body: some View {
		NavigationStack {
			Form {
				Section {
					TextField("Name", text: $destination.name)
					TextField("Location", text: $destination.location)
					
					NumericField("Latitude Coordinate", text: $destination.latitude)
					NumericField("Longitude Coordinate", text: $destination.longitude)
				} footer: {
					Text("Latitude and longitude are optional. Both must be either empty or populated, not just one.")
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
