//
//  EditWeightScreen+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import SwiftUI
import CoreData

extension EditWeightScreen {
    @Observable
    class ViewModel {
        var weight: Double
        var dateWeighed: Date
        var unit: WeightUnit
        var error: GTError?
        var isShowingError: Bool
        var shouldDismiss: Bool
        
        var weightFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 0
            
            return formatter
        }
        
        init(weight: Double, dateWeighed: Date, unit: WeightUnit) {
            self.weight = weight
            self.dateWeighed = dateWeighed
            self.unit = unit
            self.isShowingError = false
            self.shouldDismiss = false
            self.error = nil
        }
        
        func incrementWeight() {
            self.weight += 0.01
        }
        
        func decrementWeight() {
            if weight > 0 {
                self.weight -= 0.01
            }
        }
        
        func cancel(context: NSManagedObjectContext) {
            if context.hasChanges {
                context.rollback()
            }
            
            shouldDismiss = true
        }
        
        func updateWeight(context: NSManagedObjectContext, oldWeight: GTWeight) {
            let dataService = DataService(context: context)
            
            do {
                try dataService.modifyWeight(oldWeight: oldWeight, value: self.weight, unit: unit.rawValue, dateWeighed: dateWeighed)
                shouldDismiss = true
            } catch {
                self.error = .updateWeightError
                isShowingError = true
            }
        }
    }
}
