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
