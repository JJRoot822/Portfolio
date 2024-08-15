//
//  GlucoseReadingCell+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/6/24.
//

import Foundation
import SwiftUI

extension GlucoseReadingCell {
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
        
        func delete(_ reading: GTGlucoseMeasurement, context: NSManagedObjectContext) {
            let service = DataService(context: context)
            
            do {
                try service.delete(measurement: reading)
            } catch {
                self.error = GTError.deleteGlucoseError
                toggleIsShowingError()
            }
        }
    }
}
