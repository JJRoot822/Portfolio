//
//  AllDestinationsView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI
import SwiftData

struct AllDestinationsView: View {
	var body: some View {
		NavigationSplitView {
			AllDestinationsSidebarView()
		} detail: {
			ContentUnavailableView("No Destination Selected", systemImage: "airplane")
		}
	}
}
