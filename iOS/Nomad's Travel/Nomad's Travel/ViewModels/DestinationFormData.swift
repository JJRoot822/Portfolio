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
	var location: String
	var latitude: String
	var longitude: String
	var priority: DestinationPriority
	var visited: Bool
	var image: UIImage?
	var notes: String
	
	var isShowingSaveError: Bool
	
	init() {
		self.destination = nil
		
		self.name = ""
		self.location = ""
		self.latitude = ""
		self.longitude = ""
		self.priority = .low
		self.visited = false
		self.image = nil
		self.notes = ""
		
		self.isShowingSaveError = false
	}
	
	init(destination: Destination) {
		self.destination = destination
		
		self.name = destination.name
		self.location = destination.location
		self.latitude = String(destination.latitude)
		self.longitude = String(destination.longitude)
		self.priority = DestinationPriority.priority(for: destination.priority)
		self.visited = destination.visited
		self.notes = destination.notes
		
		if let data = destination.image {
			self.image = UIImage(data: data)
		} else {
			self.image = nil
		}
		
		self.isShowingSaveError = false
	}
	
	func isValidDestination() -> Bool {
		return DestinationValidator.isValidDestination(name: name, location: location, latitude: latitude, longitude: longitude)
	}
	
	func save(context: ModelContext) {
		if let destination = destination {
			applyChanges(context: context)
		} else {
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
			applyChanges(context: context)
		}
	}
	
	private func applyChanges(context: ModelContext) {
		do {
			try context.save()
		} catch {
			isShowingSaveError = true
		}
	}
}
