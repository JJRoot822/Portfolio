//
//  Course+CoreDataHelper.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/19/25.
//

import Foundation

extension Course {
	var courseId: UUID {
		set { id = newValue }
		get { id ?? UUID() }
	}
	
	var courseName: String {
		set { name = newValue }
		get { name ?? "Unnamed" }
	}
	
	var courseCatalogNumber: String {
		set { courseNumber = newValue }
		get { courseNumber ?? "No Number Provided" }
	}
	
	var courseInstructor: String {
		set { instructor = newValue }
		get { instructor ?? "No instructor" }
	}
	
	var courseAssignmentCategories: [AssignmentCategory] {
		return categories?.allObjects as? [AssignmentCategory] ?? []
	}
	
	var courseSessions: [CourseSession] {
		return sessions?.allObjects as? [CourseSession] ?? []
	}
	
	var formattedCredits: String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.maximumFractionDigits = 2
		
		return formatter.string(from: NSNumber(value: credits))!
	}
}
