//
//  AllDestinationsView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI

struct AllDestinationsView: View {
	var body: some View {
		NavigationSplitView {
			AllDestinationsListView()
		} detail: {
			ContentUnavailableView("No Destination Selected", systemImage: "airplane")
		}
	}
}
