//
//  ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 7/16/24.
//

import SwiftUI
import CoreData

extension FilterableGlucoseDataTable  {
    @Observable
    class ViewModel {
        var isShowingEditBloodSugarScreen: Bool = false
        var isDeleteRequested: Bool = false
        var error: GTError?
        var isShowingError: Bool = false
        
        func toggleShowEditBloodSugarScreen() {
            self.isShowingEditBloodSugarScreen.toggle()
        }

        func getColorBy(value: Double, inRangeHighValue: Double, inRangeLowValue: Double, tooLowHighValue: Double, tooHighLowValue: Double) -> Color {
            if value <= tooLowHighValue {
                return .red
            } else if value > tooLowHighValue && value < inRangeLowValue {
                return .yellow
            } else if value >= inRangeLowValue && value <= inRangeHighValue {
                return .green
            } else if value > inRangeHighValue && value < tooHighLowValue {
                return .yellow
            }
            
            return .red
        }
        
        func toggleIsDeleteRequested() {
            self.isDeleteRequested.toggle()
        }
        
        func toggleIsShowingError() {
            isShowingError.toggle()
        }
        
        func delete(record: GTGlucoseMeasurement, context: NSManagedObjectContext) {
            let service = DataService(context: context)
            
            do {
                try service.delete(measurement: record)
            } catch {
                self.error = GTError.deleteGlucoseError
                toggleIsShowingError()
            }
        }
    }
}
