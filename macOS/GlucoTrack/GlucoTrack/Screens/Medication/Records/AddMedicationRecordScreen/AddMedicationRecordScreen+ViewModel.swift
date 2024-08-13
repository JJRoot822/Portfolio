//
//  AddMedicationRecordScreen+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/7/24.
//

import SwiftUI
import CoreData

extension AddMedicationRecordScreen {
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
        
        func incrementDoseTaken() {
            
        }
        
        func decrementDoseTaken() {
            
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
        
        func addMedicationRecord(context: NSManagedObjectContext) {
            let dataService = DataService(context: context)
            
            guard let medication = medication else {
                error = .invalidMedicationEntryError
                isShowingError = true
                
                return
            }
            
            do {
                try dataService.addMedicationRecord(
                    doseAmountTaken: doseTaken,
                    doseUnit: doseUnit,
                    notes: notes,
                    medication: medication
                )
                shouldDismiss = true
            } catch {
                self.error = GTError.insertMedRecordError
                isShowingError = true
            }
        }
    }
}
