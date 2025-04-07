//
//  TagSortOrder.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/6/25.
//

import Foundation

enum TagSortOrder: String, CaseIterable {
	case titleAscending = "Title (Ascending)",
		 titleDescending = "Title (Descending)"
	
	static var allCases: [TagSortOrder] {
		return [ .titleAscending, .titleDescending ]
	}
	
	static func sortDescriptor(for order: TagSortOrder) -> SortDescriptor<Tag> {
		switch order {
		case .titleAscending:
			return SortDescriptor(\.title, order: .forward)
		case .titleDescending:
			return SortDescriptor(\.title, order: .reverse)
		}
	}
}

