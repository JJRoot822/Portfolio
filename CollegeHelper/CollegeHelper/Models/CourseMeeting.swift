//
//  CourseMeeting.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/25/25.
//

import Foundation

struct CourseMeeting {
	let session: CourseSession
	
	var day: MeetingDay { MeetingDay.getDay(from: session.sessionDay)! }
	var startTime: String { session.fullStartTime }
	var endTime: String { session.fullEndTime }
	
	init(session: CourseSession) {
		self.session = session
	}
}
