//
//  AddBloodSugarReadingScreen+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 6/29/24.
//

import SwiftUI
import CoreData

extension AddBloodSugarReadingScreen {
    @Observable
    class ViewModel {
        var level: Double = 0
        var unit: String = "mg/dL"
        var dateMeasured: Date = Date()
        var notes: String = ""
        var charactersInNote: Int = 0
        var error: GTError?
        var isShowingError: Bool = false
        var shouldDismiss: Bool = false
        
        var levelFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 1
            
            return formatter
        }
        
        func fullUnitOfMeasure(from: String) -> String {
            if from == "mmol/L" {
                return "Millimoles Per Liter"
            } else {
                return "Milligrams Per Deciliter"
            }
        }
        
        func gaugeColor(_ value: Double) -> Color {
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
        
        func addReading(context: NSManagedObjectContext) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.addReading(level: self.level, unit: self.unit, dateMeasured: self.dateMeasured, notes: self.notes)
                shouldDismiss = true
            } catch {
                self.error = GTError.insertGlucoseError
                isShowingError = true
            }
        }
    }
}
