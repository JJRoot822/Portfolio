//
//  DestinationDetailView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI
import MapKit

struct DestinationDetailView: View {
	@Environment(\.locationManager) var locationManager

	@State private var isShowingError: Bool = false
	@State private var location: CLLocation?
	
	@State private var position = MapCameraPosition.region(
		MKCoordinateRegion(
			center: CLLocationCoordinate2D(
				latitude: 38.7946,
				longitude: 106.5348
			),
			span: MKCoordinateSpan(
				latitudeDelta: 100,
				longitudeDelta: 100
			)
		)
	)
	
	var destination: Destination
	
	var body: some View {
		GeometryReader { proxy in
			VStack {
				Form {
					if let data = destination.image,
					   let image = UIImage(data: data){
						HStack {
							Spacer()
							
							Image(uiImage: image)
								.resizable()
								.scaledToFit()
								.frame(width: proxy.size.width, height: 450)
								.clipShape(Circle())
							
							Spacer()
						}
					}
					HStack {
						Text("Destination Name")
						
						Spacer()
						
						Text(destination.name)
							.foregroundStyle(.secondary)
					}
					
					HStack {
						Text("Destination Location")
						
						Spacer()
						
						if let state = destination.state {
							Text("\(destination.city), \(state) \(destination.country)")
								.foregroundStyle(.secondary)
						} else {
							Text("\(destination.city) \(destination.country)")
								.foregroundStyle(.secondary)
						}
					}
					
					HStack {
						Text("Priority")
						
						Spacer()
						
						Text(DestinationPriority.priority(for: destination.priority).rawValue)
							.foregroundStyle(.secondary)
					}
					
					HStack {
						Text("Visited")
						
						Spacer()
						
						if destination.visited {
							Text("Yes")
								.foregroundStyle(.secondary)
						} else {
							Text("No")
								.foregroundStyle(.secondary)
						}
					}
					
					VStack(spacing: 20) {
						Text("Additional Notes")
						
						Text(destination.notes)
							.foregroundStyle(.secondary)
					}
				}
				.frame(height: proxy.size.height / 2)
				
				Map(position: $position, interactionModes: [ .all ]) {
					if let location = location {
						Marker(destination.name, coordinate: location.coordinate)
					}
				}
				.mapStyle(.hybrid(elevation: .realistic))
			}
		}
		.alert(Constants.destinationGeocodingErrorTitle, isPresented: $isShowingError) {
			Button("OK") {
				isShowingError = false
			}
		} message: {
			Text(Constants.destinationGeocodingErrorMessage)
		}
		.onAppear {
			locationManager.checkAuthorization()
		}
		.task {
			await updateLocation()
		}
	}
	
	private func updateLocation() async {
		do {
			location = try await locationManager.getLocationFromAddress(name: destination.name, city: destination.city, state: destination.state, country: destination.country, zipCode: destination.zipCode)
			
			if let location = location {
				position = MapCameraPosition.region(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 1.5, longitudeDelta: 1.5)))
			}
		} catch {
			isShowingError = true
		}
	}
}
