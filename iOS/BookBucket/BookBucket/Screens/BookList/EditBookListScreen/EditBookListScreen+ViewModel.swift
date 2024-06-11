//
//  EditBookListScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/11/24.
//

import SwiftData

extension EditBookListScreen {
    @Observable
    class ViewModel {
        var shouldDismiss: Bool = false
        var isShowingError: Bool = false
        var isShowingRequirementsPopover: Bool = false
        
        func toggleRequirementsPopover() {
            isShowingRequirementsPopover.toggle()
        }
        
        func cancel(context: ModelContext) {
            if context.hasChanges {
                context.rollback()
            }
            
            shouldDismiss = true
        }
        
        func saveChanges(context: ModelContext) {
            let dataHelper = DataHelper()
            let result = dataHelper.save(context: context)
            
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
