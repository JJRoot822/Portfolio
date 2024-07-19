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
        var id: UUID = UUID()
        var isShowingEditBloodSugarScreen: Bool = false
        var isDeleteRequested: Bool = false
        var error: GTError?
        var isShowingError: Bool = false
        
        func toggleShowEditBloodSugarScreen() {
            self.isShowingEditBloodSugarScreen.toggle()
        }
        
        func toggleIsDeleteRequested() {
            self.isDeleteRequested.toggle()
        }
        
        func toggleIsShowingError() {
            isShowingError.toggle()
        }
        
        func delete(_ readings: [GTGlucoseMeasurement], context: NSManagedObjectContext) {
            let service = DataService(context: context)
            
            readings.forEach { reading in
                do {
                    try service.delete(measurement: reading)
                } catch {
                    self.error = GTError.deleteGlucoseError
                    toggleIsShowingError()
                }
            }
        }
    }
}
