//
//  GTMedicationRecord+CoreDataHelper.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/26/24.
//

import CoreData

extension GTMedicationRecord {
    var dosageUnit: String {
        return unit ?? "Unknown"
    }
    
    var consumptionNotes: String {
        return notes ?? ""
    }
    
    var formattedDateTaken: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        
        return formatter.string(from: dateMedicationTaken)
    }
    
    var dateMedicationTaken: Date {
        return dateTaken ?? Date()
    }
}
