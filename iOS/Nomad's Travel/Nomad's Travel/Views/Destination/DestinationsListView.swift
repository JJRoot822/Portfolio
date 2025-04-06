//
//  DestinationsListView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI
import SwiftData

struct DestinationsListView: View {
	var sort: DestinationSortOrder
	var filter: DestinationFilter
	var priority: DestinationPriority
	var searchTerm: String
	var tag: Tag?
	
	@Query var destinations: [Destination]
	
	init(sort: DestinationSortOrder, filter: DestinationFilter, priority: DestinationPriority, searchTerm: String, tag: Tag? = nil) {
		self.sort = sort
		self.filter = filter
		self.priority = priority
		self.searchTerm = searchTerm
		self.tag = tag
		
		let searchAllPredicate = #Predicate<Destination> { destination in
			return destination.name.localizedStandardContains(searchTerm) ||
				   destination.city.localizedStandardContains(searchTerm) ||
				   destination.country.localizedStandardContains(searchTerm)
		}
		
		let searchVisitedPredicate = #Predicate<Destination> { destination in
			return destination.name.localizedStandardContains(searchTerm) ||
				   destination.city.localizedStandardContains(searchTerm) ||
				   destination.country.localizedStandardContains(searchTerm) &&
				   destination.visited == true
		}
		
		let searchNotVisitedPredicate = #Predicate<Destination> { destination in
			return destination.name.localizedStandardContains(searchTerm) ||
				   destination.city.localizedStandardContains(searchTerm) ||
				   destination.country.localizedStandardContains(searchTerm) &&
				   destination.visited == false
		}
		
		let visitedPredicate = #Predicate<Destination> { destination in
			return destination.visited == true
		}
		
		let notVisitedPredicate = #Predicate<Destination> { destination in
			return destination.visited == false
		}
		
		var fetchDescriptor = FetchDescriptor<Destination>()
		fetchDescriptor.sortBy = [ DestinationSortOrder.sortDescriptor(for: sort) ]
		fetchDescriptor.relationshipKeyPathsForPrefetching = [ \.tags ]
		
		if searchTerm.isEmpty {
			switch filter {
			case .all:
				fetchDescriptor.predicate = nil
			case .visited:
				fetchDescriptor.predicate = visitedPredicate
			case .unvisited:
				fetchDescriptor.predicate = notVisitedPredicate
			}
		} else {
			switch filter {
			case .all:
				fetchDescriptor.predicate = searchAllPredicate
			case .visited:
				fetchDescriptor.predicate = searchVisitedPredicate
			case .unvisited:
				fetchDescriptor.predicate = searchNotVisitedPredicate
			}
		}
		
		self._destinations = Query(fetchDescriptor, animation: .default)
	}
	
	var filteredDestinations: [Destination] {
		if let tag = tag {
			return destinations.filter { destination in
				destination.tags.contains(tag) &&
				destination.priority == DestinationPriority.intValue(for: priority)
			}
		}
		
		return destinations
	}

	var body: some View {
		List {
			ForEach(destinations, id: \.id) { destination in
				DestinationCellView(destination: destination)
			}
		}
	}
}


