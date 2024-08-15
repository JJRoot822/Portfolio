//
//  GTWeight+CoreDataHelper.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/26/24.
//

import CoreData

extension GTWeight {
    var weightUnit: String {
        return unit ?? "Unknown"
    }
    
    var dateMeasured: Date {
        return dateWeighed ?? Date()
    }
    
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        
        return formatter.string(from: NSNumber(value: value))!
    }
    
    var formattedDateMeasured: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        
        return formatter.string(from: dateMeasured)
    }
}
