//
//  DestinationFormData.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/28/25.
//

import SwiftUI
import SwiftData

@Observable
class DestinationFormData {
	var destination: Destination?
	
	var name: String
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
	
	init() {
		self.destination = nil
		
		self.name = ""
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
	
	init(destination: Destination) {
		self.destination = destination
		
		self.name = destination.name
		self.city = destination.city
		self.country = destination.country
		self.zipCode = destination.zipCode
		
		if let state = destination.state {
			self.state = state
		} else {
			self.state = "None"
		}
		
		self.priority = DestinationPriority.priority(for: destination.priority)
		self.visited = destination.visited
		self.notes = destination.notes
		
		if let data = destination.image {
			self.image = UIImage(data: data)
		} else {
			self.image = nil
		}
		
		self.isShowingSaveError = false
		self.shouldDismiss = false
	}
	
	func isValidDestination() -> Bool {
		return DestinationValidator.isValidDestination(name: name, city: city, country: country, zipCode: zipCode)
	}
	
	func save(context: ModelContext) {
		if let destination = destination {
			destination.name = name
			destination.city = city
			destination.state = state == "None" ? nil : state
			destination.country = country
			destination.zipCode = zipCode
			destination.visited = visited
			destination.priority = DestinationPriority.intValue(for: priority)
			destination.notes = notes
			destination.lastModifiedAt = .now
			destination.image = image?.jpegData(compressionQuality: 0.1)
			
			applyChanges(context: context)
		} else {
			let destination = Destination(
				name: name,
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
			
			context.insert(destination)
			applyChanges(context: context)
		}
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
