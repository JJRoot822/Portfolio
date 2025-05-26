//
//  AssignmentOutlineItem.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/19/25.
//

import Foundation

struct AssignmentOutlineItem: OutlineViewItem {
    let assignment: Assignment
	var name: String { assignment.assignmentName }
	var pointsPossible: String { assignment.formattedPointsPossible }
	var pointsEarned: String { assignment.formattedPointsEarned }
	var status: AssignmentStatus { AssignmentStatus.getStatus(for: Int(assignment.status)) }
	var dateAssigned: String { assignment.formattedDateAssigned }
	var dueDate: String { assignment.formattedDueDate }
	var dateAssignedTimeZone: String { assignment.assignmentDateAssignedTimeZone }
	var dueDateTimeZone: String { assignment.assignmentDueDateTimeZone }
	var children: [OutlineViewItem]? = nil
    var representedObject: Any? { assignment }

    init(assignment: Assignment) {
        self.assignment = assignment
    }
}
