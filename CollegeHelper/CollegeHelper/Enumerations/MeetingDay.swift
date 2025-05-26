//
//  MeetingDay.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/25/25.
//

import Foundation

enum MeetingDay: String, CaseIterable {
	case monday = "Monday", tuesday = "Tuesday", wednesday = "Wednesday", thursday = "Thursday", friday = "Friday"
	
	static func getDay(from string: String) -> MeetingDay? {
		return MeetingDay(rawValue: string)
	}
}
