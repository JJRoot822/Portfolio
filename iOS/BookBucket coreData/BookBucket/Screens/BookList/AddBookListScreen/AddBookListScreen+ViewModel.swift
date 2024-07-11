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
            let dataService = DataService(context: context)
            let result = dataService.insert(model: bookList)
            
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
