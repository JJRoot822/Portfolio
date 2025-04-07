//
//  DestinationImageView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI

struct DestinationImageView: View {
	var destination: Destination
	
	var body: some View {
		if let data = destination.image {
			Image(uiImage: UIImage(data: data)!)
				.resizable()
				.scaledToFit()
				.frame(width: 75, height: 75)
		} else {
			Image(systemName: "camera")
				.resizable()
				.scaledToFit()
				.frame(width: 75, height: 75)
		}
	}
}
