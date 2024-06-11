//
//  EditGenreScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/11/24.
//

import SwiftData

extension EditGenreScreen {
    @Observable
    class ViewModel {
        var isShowingRequirementsPopover: Bool = false
        var isShowingError: Bool = false
        var shouldDismiss: Bool = false
        
        func cancel(context: ModelContext) {
            if context.hasChanges {
                context.rollback()
            }
            
            shouldDismiss = true
        }
        
        func toggleRequirementsPopover() {
            isShowingRequirementsPopover.toggle()
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
            }
            
            self.isShowingError = true
        }
    }
}
