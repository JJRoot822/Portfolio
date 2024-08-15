//
//  MedicationCell+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/6/24.
//

import Foundation
import SwiftUI
import CoreData

extension MedicationCell {
    @Observable
    class ViewModel {
        var id: UUID = UUID()
        var isShowingEditMedicationScreen: Bool = false
        var isDeleteRequested: Bool = false
        var error: GTError?
        var isShowingError: Bool = false
        
        func toggleShowEditMedicationScreen() {
            self.isShowingEditMedicationScreen.toggle()
        }
        
        func toggleIsDeleteRequested() {
            self.isDeleteRequested.toggle()
        }
        
        func toggleIsShowingError() {
            isShowingError.toggle()
        }
        
        func delete(_ medication: GTMedication, context: NSManagedObjectContext) {
            let service = DataService(context: context)
            
            do {
                try service.delete(medication: medication)
            } catch {
                self.error = GTError.deleteGlucoseError
                toggleIsShowingError()
            }
        }
    }
}
