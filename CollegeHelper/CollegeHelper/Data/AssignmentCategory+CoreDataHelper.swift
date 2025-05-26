//
//  AssignmentCategory+CoreDataHelper.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/20/25.
//

import Foundation

extension AssignmentCategory {
	var categoryId: UUID {
		set { id = newValue }
		get { id ?? UUID() }
	}
	
	var categoryName: String {
		set { name = newValue }
		get { name ?? "Unnamed" }
	}
	
	var categoryAssignments: [Assignment] {
		return assignments?.allObjects as? [Assignment] ?? []
	}
}
