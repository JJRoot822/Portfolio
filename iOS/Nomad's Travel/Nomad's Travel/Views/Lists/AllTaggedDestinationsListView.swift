//
//  AllTaggedDestinationsListView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/7/25.
//

import SwiftUI

struct AllTaggedDestinationsListView: View {
	@State private var selectedSort: DestinationSortOrder = .nameAscending
	@State private var selectedFilter: DestinationFilter = .all
	@State private var selectedPriority: DestinationPriority = .all
	@State private var searchTerm: String = ""
	@State private var isShowingAddView: Bool = false

	var tag: Tag
	
	var body: some View {
		DestinationsListView(sort: selectedSort, filter: selectedFilter, priority: selectedPriority, searchTerm: searchTerm, tag: tag)
			.navigationTitle(Text("Destinations"))
			.searchable(text: $searchTerm, placement: .sidebar, prompt: Text("Search for a Destination"))
			.sheet(isPresented: $isShowingAddView) {
				
				AddTaggedDestinationView(tag: tag)
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

