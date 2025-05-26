//
//  CourseSortOption.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/25/25.
//

import Foundation

enum CourseSortOption: Int, CaseIterable {
	case ascendingName = 1, descendingName = 2
	
	var stringRepresentation: String {
		switch self {
		case .ascendingName: "Ascending by Course Name"
		case .descendingName: "Descending by Course Name"
		}
	}
	
	static func getSortOption(from intValue: Int) -> CourseSortOption? {
		return CourseSortOption(rawValue: intValue)
	}
}
