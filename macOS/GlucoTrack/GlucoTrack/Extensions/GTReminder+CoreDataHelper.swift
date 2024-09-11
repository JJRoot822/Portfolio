//
//  GTReminder+CoreDataHelper.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/14/24.
//

import CoreData

extension GTReminder {
    var reminderId: UUID {
        return id ?? UUID()
    }
    
    var reminderNotificationId: String {
        return notificationId ?? UUID().uuidString
    }
    
    var reminderScheduledDate: Date {
        return scheduled ?? Date()
    }
}
