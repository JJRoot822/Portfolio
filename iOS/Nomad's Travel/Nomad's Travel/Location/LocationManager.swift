//
//  LocationManager.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/28/25.
//

import SwiftUI
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
	@Published var userLocation: CLLocationCoordinate2D?
	
	var manager: CLLocationManager
	
	override init() {
		self.manager = CLLocationManager()
		
		super.init()
		
		manager.delegate = self
		manager.startUpdatingLocation()
	}
	
	func checkAuthorization() {
		switch manager.authorizationStatus {
		case .authorizedWhenInUse:
			userLocation = manager.location?.coordinate
		default:
			break
		}
	}
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		checkAuthorization()
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		userLocation = locations.first?.coordinate
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
