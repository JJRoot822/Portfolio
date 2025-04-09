//
//  Destination.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import Foundation
import SwiftData
import CoreLocation

@Model
class Destination {
	var destinationId: UUID
	var name: String
	var streetAddress: String
	var city: String
	var state: String?
	var country: String
	var zipCode: String
	var priority: Int
	var visited: Bool
	@Attribute(.externalStorage) var image: Data?
	var notes: String
	var createdAt: Date
	var lastModifiedAt: Date
	var tags: [Tag]
	
	init(
		id: UUID = UUID(),
		name: String,
		streetAddress: String,
		city: String,
		state: String?,
		country: String,
		zipCode: String,
		priority: Int,
		visited: Bool,
		image: Data? = nil,
		notes: String,
		createdAt: Date = .now,
		lastModifiedAt: Date = .now,
		tags: [Tag]
	) {
		self.destinationId = id
		self.name = name
		self.streetAddress = streetAddress
		self.city = city
		self.state = state
		self.country = country
		self.zipCode = zipCode
		self.priority = priority
		self.visited = visited
		self.image = image
		self.notes = notes
		self.createdAt = createdAt
		self.lastModifiedAt = lastModifiedAt
		self.tags = tags
	}
}
