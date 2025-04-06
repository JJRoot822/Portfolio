//
//  LocationManager.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/28/25.
//

import SwiftUI
import CoreLocation

class LocationManager: ObservableObject {
	@Published var userLocation: CLLocationCoordinate2D?
	
	var manager: CLLocationManager
	
	init() {
		self.manager = CLLocationManager()
	}
	
	func getLocationFromAddress(name: String, city: String, state: String?, country: String, zipCode: String) async throws -> CLLocation? {
		let coder = CLGeocoder()
		
		if let state = state {
			return try await coder.geocodeAddressString("\(name) \(city), \(state) \(zipCode) \(country)")[0].location
		} else {
			return try await coder.geocodeAddressString("\(name) \(city), \(country) \(zipCode)")[0].location
		}
	}
}
