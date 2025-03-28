//
//  AllDestinationsSidebarView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI
import SwiftData

struct AllDestinationsSidebarView: View {
	@State private var selectedSort: DestinationSortOrder = .nameAscending
	@State private var selectedFilter: DestinationFilter = .all
	@State private var selectedPriority: DestinationPriority = .all
	@State private var searchTerm: String = ""
	@State private var isShowingAddView: Bool = false
	
	var body: some View {
		DestinationsListView(sort: selectedSort, filter: selectedFilter, priority: selectedPriority, searchTerm: searchTerm)
			.navigationTitle(Text("Nomad's Travel"))
			.searchable(text: $searchTerm, placement: .sidebar, prompt: Text("Search for a Destination"))
			.sheet(isPresented: $isShowingAddView) {
				AddDestinationView()
			}
			.toolbar {
				ToolbarItem(placement: .primaryAction) {
					Button {
						isShowingAddView.toggle()
					} label: {
						Label("Add Destination", systemImage: "plus")
					}
				}
				
				ToolbarItem(placement: .bottomBar) {
					DestinationsListBottomToolbarView(
						selectedPriority: $selectedPriority,
						selectedSort: $selectedSort,
						selectedFilter: $selectedFilter
					)
				}
			}
	}
}
