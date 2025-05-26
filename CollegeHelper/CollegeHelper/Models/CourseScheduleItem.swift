//
//  CourseScheduleItem.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/25/25.
//

import Foundation

struct CourseScheduleItem {
	let course: Course
	
	var name: String { course.courseName }
	var courseNumber: String { course.courseCatalogNumber }
	var instructor: String { course.courseInstructor }
	var credits: String { course.formattedCredits }
	var courseType: CourseType { CourseType.getType(from: Int(course.courseType))! }
	
	var sessions: [CourseMeeting] { course.courseSessions.map(CourseMeeting.init) }
	
	init(course: Course) {
		self.course = course
	}
}
