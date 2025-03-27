//
//  Tag.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import Foundation
import SwiftData

@Model
class Tag {
	var id: UUID
	var title: String
	var color: String
	var createdAt: Date
	var lastModifiedAt: Date
	@Relationship(inverse: \Destination.tags) var destinations: [Destination]
	
	init(id: UUID = UUID(), title: String, color: String, createdAt: Date = .now, lastModifiedAt: Date = .now, destinations: [Destination]) {
		self.id = id
		self.title = title
		self.color = color
		self.createdAt = createdAt
		self.lastModifiedAt = lastModifiedAt
		self.destinations = destinations
	}
	
}
