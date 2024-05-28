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
    
    var originalPrescriptionDate: Date {
        return datePrescribed ?? Date()
    }
    
    var dosageUnit: String {
        return doseUnit ?? "Unknown"
    }
    
    var consumptionRecords: [GTMedicationRecord] {
        return records?.allObjects as? [GTMedicationRecord] ?? []
    }
}
