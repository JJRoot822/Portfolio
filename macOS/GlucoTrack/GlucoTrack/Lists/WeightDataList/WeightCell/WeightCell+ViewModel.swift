//
//  WeightCell+ViewModel.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/13/24.
//

import SwiftUI
import CoreData

extension WeightCell {
    @Observable
    class ViewModel {
        var id: UUID = UUID()
        var isShowingEditWeightScreen: Bool = false
        var isDeleteRequested: Bool = false
        var error: GTError?
        var isShowingError: Bool = false
        
        func toggleShowEditWeightScreen() {
            self.isShowingEditWeightScreen.toggle()
        }
        
        func toggleIsDeleteRequested() {
            self.isDeleteRequested.toggle()
        }
        
        func toggleIsShowingError() {
            isShowingError.toggle()
        }
        
        func delete(_ weight: GTWeight, context: NSManagedObjectContext) {
            let service = DataService(context: context)
            
            do {
                try service.delete(weight: weight)
            } catch {
                self.error = GTError.deleteWeightError
                toggleIsShowingError()
            }
        }
    }
}
