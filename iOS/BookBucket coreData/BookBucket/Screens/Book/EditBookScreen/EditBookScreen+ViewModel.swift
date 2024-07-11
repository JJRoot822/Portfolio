//
//  EditBookScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 5/30/24.
//

import SwiftUI
import SwiftData

extension EditBookScreen {
    @Observable
    class ViewModel {
        var isShowingError: Bool = false
        var isShowingRequirementsPopover: Bool = false
        var shouldDismiss: Bool = false
        
        var integerFormatter: NumberFormatter {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 0
            
            return formatter
        }
        
        func cancel(context: ModelContext) {
            if context.hasChanges {
                context.rollback()
            }
            
            shouldDismiss = true
        }
        
        func saveChanges(context: ModelContext) {
            let dataService = DataService(context: context)
            let result = dataService.save()
            
            switch result {
            case .success(()):
                shouldDismiss = true
                return
            case .failure(_):
                if context.hasChanges {
                    context.rollback()
                }
                
                isShowingError = true
            }
        }
    }
}
