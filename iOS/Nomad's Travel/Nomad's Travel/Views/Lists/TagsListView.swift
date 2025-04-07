//
//  TagsListView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/6/25.
//

import SwiftUI
import SwiftData

struct TagsListView: View {
	var sort: TagSortOrder
	var searchTerm: String
	
	@Query var tags: [Tag]
	
	init(sort: TagSortOrder, searchTerm: String) {
		self.sort = sort
		self.searchTerm = searchTerm
		
		var fetchDescriptor = FetchDescriptor<Tag>()
		fetchDescriptor.sortBy = [TagSortOrder.sortDescriptor(for: sort) ]
		
		if !searchTerm.isEmpty {
			fetchDescriptor.predicate = #Predicate<Tag> { tag in
				return tag.title.localizedStandardContains(searchTerm)
			}
		}
		
		self._tags = Query(fetchDescriptor, animation: .default)
	}
	
	var body: some View {
		List {
			ForEach(tags, id: \.id) { tag in
				TagCellView(tag: tag)
			}
		}
	}
}



