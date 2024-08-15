//
//  NotificationsService.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/14/24.
//

import UserNotifications

class NotificationsService {
    private let center = UNUserNotificationCenter.current()
    
    func requestPermission() async throws {
        do {
            try await center.requestAuthorization(options: [ .alert, .sound ])
        } catch {
            throw error
        }
    }
    
    func isAuthorized() async -> Bool {
        let settings = await center.notificationSettings()
        let status = settings.authorizationStatus
        
        return status == .authorized
    }
    
    func scheduleNotification(forComponents: DateComponents, withIdentifier: String, repeats: Bool, title: String, body: String) async throws {
        let authorized = await isAuthorized()
        
        guard authorized else {
            throw GTError.notAuthorizedError
        }
        
        let content = UNMutableNotificationContent()
        let trigger = UNCalendarNotificationTrigger(dateMatching: forComponents, repeats: repeats)
        let sound = UNNotificationSound.default
        
        content.title = title
        content.body = body
        content.sound = sound
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    
        do {
            try await center.add(request)
        } catch {
            throw error
        }
    }
}
