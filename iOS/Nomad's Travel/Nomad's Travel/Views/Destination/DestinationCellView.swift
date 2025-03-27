//
//  DestinationCellView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI

struct DestinationCellView: View {
	var destination: Destination
	
	var destinationPriority: String {
		return DestinationPriority.priority(for: destination.priority).rawValue
	}
	
	var body: some View {
		NavigationLink {
			DestinationDetailView(destination: destination)
		} label: {
			HStack {
				DestinationImageView(destination: destination)
				
				VStack {
					Text(destination.name)
						.font(.headline)
					
					Text(destination.location)
						.font(.subheadline)
						.foregroundStyle(.secondary)
					
					Text("\(destinationPriority) Priority")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				}
			}
		}
	}
}
