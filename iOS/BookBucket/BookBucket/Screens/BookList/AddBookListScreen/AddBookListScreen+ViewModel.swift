//
//  AddBookListScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/8/24.
//

import SwiftData

extension AddBookListScreen {
    @Observable
    class ViewModel {
        var shouldDismiss: Bool = false
        var title: String = ""
        var isFavorite: Bool = false
        var color: String = "Blue"
        var isShowingError: Bool = false
        var isShowingRequirementsPopover: Bool = false
        
        func toggleRequirementsPopover() {
            isShowingRequirementsPopover.toggle()
        }
        
        func cancel() {
            shouldDismiss = true
        }
        
        func create(context: ModelContext) {
            let bookList = BookList(title: title, color: color, isFavorite: isFavorite, books: [])
            let dataHelper = DataHelper()
            let result = dataHelper.insert(context: context, model: bookList)
            
            switch result {
            case .success(()):
                cancel()
                
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
