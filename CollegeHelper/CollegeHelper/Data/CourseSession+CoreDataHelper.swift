//
//  CourseSession+CoreDataHelper.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/19/25.
//

import Foundation

extension CourseSession {
	var sessionId: UUID {
		set { id = newValue }
		get { id ?? UUID() }
	}
	
	var sessionDay: String {
		set { day = newValue }
		get { day ?? "Unknown Day of the Week" }
	}
	
	var sessionStartTime: Date {
		set { startTime = newValue }
		get { startTime ?? Date() }
	}
	
	var sessionStartTimeZone: String {
		set { startTimeZone = newValue }
		get { startTimeZone ?? Calendar.current.timeZone.identifier }
	}
	
	var sessionEndTime: Date {
		set { endTime = newValue }
		get { endTime ?? Date() }
	}
	
	var sessionEndTimeZone: String {
		set { endTimeZone = newValue }
		get { endTimeZone ?? Calendar.current.timeZone.identifier }
	}
	
	var sessionMeetingLocation: String {
		set { meetingLocation = newValue }
		get { meetingLocation ?? "No Meeting Location Specified" }
	}
	
	var formattedStartTime: String {
		let formatter = DateFormatter()
		formatter.dateStyle = .none
		formatter.timeStyle = .short
		
		return formatter.string(from: sessionStartTime)
	}
	
	var formattedEndTime: String {
		let formatter = DateFormatter()
		formatter.dateStyle = .none
		formatter.timeStyle = .short
		
		return formatter.string(from: sessionEndTime)
	}
	
	var fullStartTime: String {
		return "\(formattedStartTime) \(sessionStartTimeZone)"
	}
	
	var fullEndTime: String {
		return "\(formattedEndTime) \(sessionEndTimeZone)"
	}
}
