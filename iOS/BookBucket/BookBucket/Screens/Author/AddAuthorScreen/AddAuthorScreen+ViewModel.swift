//
//  AddAuthorScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 5/29/24.
//

import SwiftUI
import SwiftData

extension AddAuthorScreen {
    @Observable
    class ViewModel {
        var authorName: String = ""
        var isFavorite: Bool = false
        var isShowingError: Bool = false
        var isShowingRequirementsPopover: Bool = false
        var shouldDismiss: Bool = false
        
        func toggleRequirementsPopover() {
            isShowingRequirementsPopover.toggle()
        }
        
        func cancel() {
            self.shouldDismiss = true
        }
        
        func create(context: ModelContext) {
            let author = Author(name: authorName, isFavorited: isFavorite, books: [])
            let dataHelper = DataHelper()
            let result = dataHelper.insert(context: context, model: author)
            
            switch result {
            case .success(()):
                self.shouldDismiss = true
                
                return
            case .failure(_):
                context.rollback()
                isShowingError = true
            }
        }
    }
}
