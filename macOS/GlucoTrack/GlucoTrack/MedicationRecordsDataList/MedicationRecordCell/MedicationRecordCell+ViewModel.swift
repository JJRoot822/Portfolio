//
//  MedicationRecordCell+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import Foundation
import SwiftUI
import CoreData

extension MedicationRecordCell {
    @Observable
    class ViewModel {
        var id: UUID = UUID()
        var isShowingEditMedicationRecordScreen: Bool = false
        var isDeleteRequested: Bool = false
        var error: GTError?
        var isShowingError: Bool = false
        
        func toggleShowEditMedicationRecordScreen() {
            self.isShowingEditMedicationRecordScreen.toggle()
        }
        
        func toggleIsDeleteRequested() {
            self.isDeleteRequested.toggle()
        }
        
        func toggleIsShowingError() {
            isShowingError.toggle()
        }
        
        func delete(_ record: GTMedicationRecord, context: NSManagedObjectContext) {
            let service = DataService(context: context)
            
            do {
                try service.delete(record: record)
            } catch {
                self.error = GTError.deleteMedRecordError
                toggleIsShowingError()
            }
        }
    }
}
