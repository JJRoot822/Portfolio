//
//  GTMedication+CoreDataHelper.swift
//  GlucoTrack
//
//  Created by Joshua Root on 5/26/24.
//

import CoreData

extension GTMedication {
    var medicationName: String {
        return name ?? "Unknown"
    }
    var medicationNotes: String {
        return notes ?? ""
    }
    
    var formattedDosageValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: doseValue)) ?? ""
    }
    
    var originalPrescriptionDate: Date {
        return datePrescribed ?? Date()
    }
    
    var formattedPrescriptionDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .short
        
        return formatter.string(from: originalPrescriptionDate)
    }
    
    var dosageUnit: String {
        return doseUnit ?? "Unknown"
    }
    
    var consumptionRecords: [GTMedicationRecord] {
        return records?.allObjects as? [GTMedicationRecord] ?? []
    }
}
