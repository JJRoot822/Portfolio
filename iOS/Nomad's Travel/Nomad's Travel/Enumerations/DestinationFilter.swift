//
//  DestinationFilter.swift
//  NomadTravel
//
//  Created by Joshua Root on 3/1/25.
//

import UIKit

enum DestinationFilter: String, CaseIterable {
    case all = "All", visited = "Visited", unvisited = "Not Visited"
	
	static var allCases: [DestinationFilter] {
		return [ .all, .visited, .unvisited ]
	}
	
	static func intValue(for filter: DestinationFilter) -> Int {
		switch filter {
		case .all:
			return 1
		case .visited:
			return 2
		case .unvisited:
			return 3
		}
	}
	
	static func filter(for value: Int) -> DestinationFilter {
		switch value {
		case 1:
			return .all
		case 2:
			return .visited
		case 3:
			return .unvisited
		default:
			return .all
		}
	}
}

