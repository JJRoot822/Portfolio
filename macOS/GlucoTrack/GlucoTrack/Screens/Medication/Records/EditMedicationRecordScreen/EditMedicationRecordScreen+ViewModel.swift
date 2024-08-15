//
//  EditMedicationRecordScreen+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/7/24.
//

import SwiftUI
import CoreData

extension EditMedicationRecordScreen {
    @Observable
    class ViewModel {
        var medication: GTMedication?
        var doseTaken: Double = 0
        var doseUnit: String = ""
        var dateTaken: Date = Date()
        var notes: String = ""
        var charactersInNote: Int = 0
        var error: GTError? = nil
        var isShowingError: Bool = false
        var shouldDismiss: Bool = false

        var dosageFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            
            return formatter
        }
        
        init(medication: GTMedication?, doseTaken: Double, doseUnit: String, dateTaken: Date, notes: String) {
            self.medication = medication
            self.doseTaken = 0
            self.doseUnit = ""
            self.dateTaken = Date()
            self.notes = ""
            self.charactersInNote = 0
            self.error = nil
            self.isShowingError = false
            self.shouldDismiss = false
        }
        
        func incrementDoseTaken() {
            doseTaken += 0.01
        }
        
        func decrementDoseTaken() {
            if doseTaken > 0 {
                doseTaken -= 0.01
            }
        }
        
        func gaugeColor(_ value: Int) -> Color {
            if value <= 120 {
                return .blue
            } else if value > 120 && value <= 150 {
                return .yellow
            } else {
                return .red
            }
        }

        func cancel(context: NSManagedObjectContext) {
            if context.hasChanges {
                context.rollback()
            }
            
            shouldDismiss = true
        }
        
        func updateMedicationRecord(context: NSManagedObjectContext, record: GTMedicationRecord) {
            let dataService = DataService(context: context)
            
            guard let medication = medication else {
                error = .invalidMedicationEntryError
                isShowingError = true
                
                return
            }
            
            do {
                try dataService.modifyMedicationRecord(oldRecord: record, doseAmountTaken: doseTaken, doseUnit: doseUnit, notes: notes, medication: medication)
                shouldDismiss = true
            } catch {
                self.error = GTError.updateMedRecordError
                isShowingError = true
            }
        }
    }
}
