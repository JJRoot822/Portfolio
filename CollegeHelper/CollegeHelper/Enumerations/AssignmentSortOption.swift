//
//  AssignmentSortOption.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/22/25.
//

import Foundation

enum AssignmentSortOption: Int, CaseIterable {
	case ascendingDueDate = 1, descendingDueDate = 2, ascendingDateAssigned = 3, descendingDateAssigned = 4
	
	var stringRepresentation: String {
		switch self {
		case .ascendingDueDate: "Ascending by Due Date"
		case .ascendingDateAssigned: "Ascending by Date Assigned"
		case .descendingDueDate: "Descending by Due Date"
		case .descendingDateAssigned: "Descending by Date Assigned"
		}
	}
	
	static func getSortOption(for intValue: Int) -> AssignmentSortOption? {
		return AssignmentSortOption(rawValue: intValue)
	}
}
