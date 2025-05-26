//
//  Constants.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/22/25.
//

import Cocoa

class Constants {
	static let appDelegate = NSApplication.shared.delegate as! AppDelegate
	static let assignmentsSortOptionKey: String = "assignments_sort_option"
	static let sidebarColumnIdentifier: NSUserInterfaceItemIdentifier = .init("sidebar_column")
	
	
	static let sidebarItems: [SidebarItem] = [
		.init(image: "gauge", title: "Dashboard"),
		.init(image: "graduationcap", title: "Courses"),
		.init(image: "doc", title: "Assignments")
	]
}
