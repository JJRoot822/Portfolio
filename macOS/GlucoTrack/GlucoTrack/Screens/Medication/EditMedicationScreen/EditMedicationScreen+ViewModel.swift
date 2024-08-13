//
//  EditMedicationScreen+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/29/24.
//

import SwiftUI
import CoreData

extension EditMedicationScreen {
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
        
        init(name: String, dosageValue: Double, dosageUnit: String, datePrescribed: Date, notes: String) {
            self.name = name
            self.dosageValue = dosageValue
            self.dosageUnit = dosageUnit
            self.datePrescribed = datePrescribed
            self.notes = notes
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
        
        func updateMedication(context: NSManagedObjectContext, medication: GTMedication) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.modifyMedication(oldMedication: medication, name: name, doseValue: dosageValue, doseUnit: dosageUnit, datePrescribed: datePrescribed, notes: notes)
                shouldDismiss = true
            } catch {
                self.error = GTError.updateMedicationError
                isShowingError = true
            }
        }
    }
}
