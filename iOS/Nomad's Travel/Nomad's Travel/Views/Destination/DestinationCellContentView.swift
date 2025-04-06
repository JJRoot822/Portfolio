//
//  DestinationCellContentView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/28/25.
//

import SwiftUI

struct DestinationCellContentView: View {
	var destination: Destination
	
	var destinationPriority: String {
		return DestinationPriority.priority(for: destination.priority).rawValue
	}
	
	var body: some View {
		HStack {
			DestinationImageView(destination: destination)
			
			VStack {
				Text(destination.name)
					.font(.headline)
				
				if let state = destination.state {
					Text("\(destination.city), \(state) \(destination.country)")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				} else {
					Text("\(destination.city), \(destination.country)")
						.font(.subheadline)
						.foregroundStyle(.secondary)
				}
				Text("\(destinationPriority) Priority")
					.font(.subheadline)
					.foregroundStyle(.secondary)
			}
		}
	}
}
