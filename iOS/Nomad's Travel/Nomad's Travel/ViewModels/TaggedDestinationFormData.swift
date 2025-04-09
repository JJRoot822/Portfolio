//
//  TaggedDestinationFormData.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/7/25.
//

import SwiftUI
import SwiftData

@Observable
class TaggedDestinationFormData {
	var tag: Tag
	
	var name: String
	var streetAddress: String
	var city: String
	var state: String
	var country: String
	var zipCode: String
	var priority: DestinationPriority
	var visited: Bool
	var image: UIImage?
	var notes: String
	
	var isShowingSaveError: Bool
	var shouldDismiss: Bool
	
	init(tag: Tag) {
		self.tag = tag
		
		self.name = ""
		self.streetAddress = ""
		self.city = ""
		self.state = ""
		self.zipCode = ""
		self.country = ""
		self.priority = .low
		self.visited = false
		self.image = nil
		self.notes = ""
		
		self.isShowingSaveError = false
		self.shouldDismiss = false
	}
	
	func isValidDestination() -> Bool {
		return DestinationValidator.isValidDestination(name: name, streetAddress: streetAddress, city: city, country: country, zipCode: zipCode)
	}
	
	func save(context: ModelContext) {
		let destination = Destination(
			name: name,
			streetAddress: streetAddress,
			city: city,
			state: state == "None" ? nil : state,
			country: country,
			zipCode: zipCode,
			priority: DestinationPriority.intValue(for: priority),
			visited: visited,
			image: image?.jpegData(compressionQuality: 0.1),
			notes: notes,
			tags: []
		)
		
		destination.tags.append(tag)
		
		context.insert(destination)
		applyChanges(context: context)
	}
	
	private func applyChanges(context: ModelContext) {
		do {
			try context.save()
			shouldDismiss = true
		} catch {
			isShowingSaveError = true
		}
	}
}

