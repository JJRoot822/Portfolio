//
//  EditBloodSugarReadingScreen+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 7/7/24.
//

import SwiftUI
import CoreData

extension EditBloodSugarReadingScreen {
    @Observable
    class ViewModel {
        var level: Double = 0
        var unit: String = "mg/dL"
        var dateMeasured: Date = Date()
        var notes: String = ""
        var charactersInNote: Int = 0
        var error: GTError?
        var isShowingError: Bool
        var shouldDismiss: Bool
        
        var levelFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 1
            
            return formatter
        }
       
        init(level: Double, unit: String, dateMeasured: Date, notes: String) {
            self.level = level
            self.unit = unit
            self.dateMeasured = dateMeasured
            self.notes = notes
            self.charactersInNote = notes.count
            self.error = nil
            self.isShowingError = false
            self.shouldDismiss = false
        }
        
        func fullUnitOfMeasure(from: String) -> String {
            if from == "mmol/L" {
                return "Millimoles Per Liter"
            } else {
                return "Milligrams Per Deciliter"
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
        
        func incrementLevel() {
            level += 0.1
        }
        
        func decrementLevel() {
            if level > 0 {
                level -= 0.1
            }
        }
        
        func updateReading(context: NSManagedObjectContext, reading: GTGlucoseMeasurement) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.modifyReading(oldReading: reading, level: level, unit: unit, dateMeasured: dateMeasured, notes: notes)
                shouldDismiss = true
            } catch {
                self.error = GTError.insertGlucoseError
                isShowingError = true
            }
        }
    }
}

