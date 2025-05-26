//
//  AssignmentStatus.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/20/25.
//

import Foundation

enum AssignmentStatus: Int, CaseIterable {
	case inProgress = 1,
	completeUngraded = 2,
	completeGraded = 3,
	incompleteNotStarted = 4,
		 incompleteNotTurnedIn = 5,
		 turnedInLate = 6,
		 unassigned = 7,
	cancelled = 8,
	excused = 9,
	other = 10
	
	var stringRepresentation:String {
		switch self {
		case .cancelled: "Cancelled"
		case .completeGraded: "Completed and Graded"
		case .completeUngraded: "Completed and Not Graded"
		case .excused: "Excused"
		case .inProgress: "In Progress"
		case .incompleteNotStarted: "Incomplete and Not Started or Due  Yet"
		case .incompleteNotTurnedIn: "Incomplete, Not Turned In and Past Due"
		case .turnedInLate: "Completed and Turned In Late"
		case .unassigned: "Not Assigned Yet"
		case .other: "Other"
		}
	}
	
	static func getStatus(for intValue: Int) -> AssignmentStatus {
		return AssignmentStatus(rawValue: intValue) ?? .other
	}
}
