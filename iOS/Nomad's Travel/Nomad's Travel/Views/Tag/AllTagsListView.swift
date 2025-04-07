//
//  AllTagsSidebarView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/6/25.
//

import SwiftUI

struct AllTagsSidebarView: View {
	@State private var selectedSort: TagSortOrder = .titleAscending
	@State private var searchTerm: String = ""
	@State private var isShowingAddView: Bool = false
	
	var body: some View {
		TagsListView(sort: selectedSort, searchTerm: searchTerm)
			.navigationTitle(Text("Tags"))
			.searchable(text: $searchTerm, placement: .sidebar, prompt: Text("Search for a Tag"))
			.popover(isPresented: $isShowingAddView) {
				AddTagView()
			}
			.toolbar {
				TagSortOrderPickerView(selection: $selectedSort)
			
				Button {
					isShowingAddView.toggle()
				} label: {
					Label("Add Tag", systemImage: "plus")
				}
			}
	}
}

