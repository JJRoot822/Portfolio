//
//  AddWeightScreen+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import SwiftUI
import CoreData

extension AddWeightScreen {
    @Observable
    class ViewModel {
        var weight: Double = 0
        var unit: WeightUnit = .pounds
        var dateWeighed: Date = Date()
        var error: GTError?
        var isShowingError: Bool = false
        var shouldDismiss: Bool = false
        
        var weightFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            
            return formatter
        }
        
        func incrementWeight() {
            weight += 0.01
        }
        
        func decrementWeight() {
            if weight > 0 {
                weight -= 0.01
            }
        }
        
        func addWeight(context: NSManagedObjectContext) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.addWeight(value: weight, unit: unit.rawValue, dateWeighed: dateWeighed)
                shouldDismiss = true
            } catch {
                self.error = GTError.insertWeightError
                isShowingError = true
            }
        }
    }
}
