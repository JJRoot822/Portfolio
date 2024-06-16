//
//  EditBookCoverScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 5/30/24.
//

import SwiftUI
import SwiftData

extension EditBookCoverScreen {
    @Observable
    class ViewModel {
        var isShowingError: Bool = false
        var shouldDismiss: Bool = false
        var isShowingImagePicker: Bool = false
        
        func toggleImagePicker() {
            isShowingImagePicker.toggle()
        }
        
        func clearCoverImage(context: ModelContext, book: Book) {
            book.coverImage = nil
            
            saveChanges(context: context)
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
