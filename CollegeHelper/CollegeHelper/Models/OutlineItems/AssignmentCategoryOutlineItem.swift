//
//  AssignmentCategoryOutlineItem.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/19/25.
//

import Foundation

struct AssignmentCategoryOutlineItem: OutlineViewItem {
    let category: AssignmentCategory
	var name: String { category.categoryName }
    var children: [OutlineViewItem]?
    var representedObject: Any? { category }

    init(category: AssignmentCategory) {
        self.category = category
		
		self.children = category.categoryAssignments.map { assignment in
			return AssignmentOutlineItem(assignment: assignment)
		}.sorted { a, b in
			guard let assignmentA = a.representedObject as? Assignment,
				  let assignmentB = b.representedObject as? Assignment else { return false }
			
			let sortOptionValue = UserDefaults.standard.integer(forKey: Constants.assignmentsSortOptionKey)
			let sortOption = AssignmentSortOption.getSortOption(for: sortOptionValue)
			
			switch sortOption {
			case .ascendingDueDate:
				return assignmentA.assignmentDueDate < assignmentB.assignmentDueDate
			case .descendingDueDate:
				return assignmentA.assignmentDueDate > assignmentB.assignmentDueDate
			case  .ascendingDateAssigned:
				return assignmentA.assignmentDateAssigned < assignmentB.assignmentDateAssigned
			case .descendingDateAssigned:
				return assignmentA.assignmentDateAssigned > assignmentB.assignmentDateAssigned
			default:
					return assignmentA.assignmentDueDate < assignmentB.assignmentDueDate
			}
		}
    }
}
