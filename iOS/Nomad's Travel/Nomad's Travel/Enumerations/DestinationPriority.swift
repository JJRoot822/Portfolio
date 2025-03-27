//
//  DestinationPriority.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI

enum DestinationPriority: String, CaseIterable {
	case all = "All Priorities",
		 low = "Low",
		 mediumm = "Medium",
		 high = "High",
		 veryHigh = "Very High"
	
	static var allCases: [DestinationPriority] {
		return [ .all, .low, .mediumm, .high, .veryHigh ]
	}
	
	static func intValue(for priority: DestinationPriority) -> Int {
		switch priority {
		case .all:
			return 1
		case .low:
			return 2
		case .mediumm:
			return 3
		case .high:
			return 4
		case .veryHigh:
			return 5
		}
	}
	
	static func priority(for value: Int) -> DestinationPriority {
		switch value {
		case 1:
			return .all
		case 2:
			return .low
		case 3:
			return .mediumm
		case 4:
			return .high
		case 5:
			return .veryHigh
		default:
			return .all
		}
	}
}
