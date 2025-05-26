//
//  CourseType.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/25/25.
//

import Foundation

enum CourseType: Int, CaseIterable {
	case coreRequirement = 1, requiredElective = 2, elective = 3
	
	var stringRepresentation: String {
		switch self {
		case .coreRequirement: "Core Requirement"
		case .requiredElective: "Required Elective"
		case .elective: "Elective"
		}
	}
	
	static func getType(from intValue: Int) -> CourseType? {
		return CourseType(rawValue: intValue)
	}
}
