//
//  GTGlucoseMeasurement+CoreDataHelper.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/26/24.
//

import CoreData

extension GTGlucoseMeasurement {
    var userNotes: String {
        return notes ?? ""
    }
    
    var  measurementUnit: String {
        return unit ?? "Unknown"
    }
    
    var measurementTakenAt: Date {
        return dateMeasured ?? Date()
    }
    
    var formattedMeasurement: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        
        return formatter.string(from: NSNumber(value: value))!
    }
    
    var formattedMeasurementDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        
        return formatter.string(from: measurementTakenAt)
    }
}
