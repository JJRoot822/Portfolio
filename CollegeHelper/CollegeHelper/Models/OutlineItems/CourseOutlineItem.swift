//
//  CourseOutlineItem.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/19/25.
//

import Foundation

struct CourseOutlineItem: OutlineViewItem {
    let course: Course
	var name: String { course.courseName }
    var children: [OutlineViewItem]?
    var representedObject: Any? { course }

    init(course: Course) {
        self.course = course
		self.children = course.courseAssignmentCategories.map { category in
			return AssignmentCategoryOutlineItem(category: category)
		}.sorted { $0.name < $1.name }
    }
}
