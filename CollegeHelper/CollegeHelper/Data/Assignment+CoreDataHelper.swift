//
//  Assignment+CoreDataHelper.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/20/25.
//

import Foundation

extension Assignment {
	var assignmentId: UUID {
		set { id = newValue }
		get { id ?? UUID() }
	}
	
	var assignmentName: String {
		set { name = newValue }
		get { name ?? "Unnamed" }
	}
	
	var assignmentDetails: String {
		set { details = newValue }
		get { details ?? "No details provided" }
	}
	
	var assignmentDateAssigned: Date {
		set { dateAssigned = newValue }
		get { dateAssigned ?? Date() }
	}
	
	var assignmentDateAssignedTimeZone: String {
		set { dateAssignedTimeZone = newValue }
		get { dateAssignedTimeZone ?? Calendar.current.timeZone.identifier }
	}
	
	var assignmentDueDate: Date {
		set { dueDate = newValue }
		get { dueDate ?? Date() }
	}
	
	var assignmentDueDateTimeZone: String {
		set { dueDateTimeZone = newValue }
		get { dueDateTimeZone ?? Calendar.current.timeZone.identifier }
	}
	
	var assignmentNotes: String {
		set { notes = newValue }
		get { notes ?? "No additional notes provided" }
	}
	
	var formattedPointsEarned: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 3
		
		return formatter.string(from: NSNumber(value: pointsEarned))!
	}
	
	var formattedPointsPossible: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.minimumFractionDigits = 2
		formatter.maximumFractionDigits = 3
		
		return formatter.string(from: NSNumber(value: pointsPossible))!
	}
	
	var formattedDueDate: String {
		let formatter = DateFormatter()
		formatter.dateStyle = .full
		formatter.timeStyle = .short
		
		return formatter.string(from: assignmentDueDate)
	}

	var formattedDateAssigned: String {
		let formatter = DateFormatter()
		formatter.dateStyle = .full
		formatter.timeStyle = .short
		
		return formatter.string(from: assignmentDateAssigned)
	}
}
