//
//  Destination.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import Foundation
import SwiftData

@Model
class Destination {
	var id: UUID
	var name: String
	var location: String
	var latitude: Double
	var longitude: Double
	var priority: Int
	var visited: Bool
	@Attribute(.externalStorage) var image: Data?
	var notes: String
	var createdAt: Date
	var lastModifiedAt: Date
	var tags: [Tag]
	
	init(id: UUID = UUID(), name: String, location: String, latitude: Double, longitude: Double, priority: Int, visited: Bool, image: Data? = nil, notes: String, createdAt: Date = .now, lastModifiedAt: Date = .now, tags: [Tag]) {
		self.id = id
		self.name = name
		self.location = location
		self.latitude = latitude
		self.longitude = longitude
		self.priority = priority
		self.visited = visited
		self.image = image
		self.notes = notes
		self.createdAt = createdAt
		self.lastModifiedAt = lastModifiedAt
		self.tags = tags
	}
}
