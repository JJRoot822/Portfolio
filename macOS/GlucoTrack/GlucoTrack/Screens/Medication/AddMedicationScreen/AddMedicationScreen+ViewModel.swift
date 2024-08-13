//
//  AddMedicationScreen+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/29/24.
//

import SwiftUI
import CoreData

extension AddMedicationScreen {
    @Observable
    class ViewModel {
        var name: String = ""
        var dosageValue: Double = 0
        var dosageUnit: String = ""
        var datePrescribed: Date = Date()
        var notes: String = ""
        var charactersInNote: Int = 0
        var error: GTError?
        var isShowingError: Bool = false
        var shouldDismiss: Bool = false
        
        var dosageFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 1
            
            return formatter
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
        
        func incrementDosage() {
            dosageValue += 0.1
        }
        
        func decrementDosage() {
            if dosageValue > 0 {
                dosageValue -= 0.1
            }
        }
        
        func addMedication(context: NSManagedObjectContext) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.addMedication(name: self.name, doseValue: dosageValue, doseUnit: dosageUnit, datePrescribed: datePrescribed, notes: self.notes)
                shouldDismiss = true
            } catch {
                self.error = GTError.insertMedicationError
                isShowingError = true
            }
        }
    }
}
