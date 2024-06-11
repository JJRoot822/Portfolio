//
//  AddGenreScreen+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/11/24.
//

import SwiftData

extension AddGenreScreen {
    @Observable
    class ViewModel {
        var genreName: String = ""
        var isFavorite: Bool = false
        var isShowingError: Bool = false
        var isShowingRequirementsPopover: Bool = false
        var shouldDismiss: Bool = false
        
        func toggleRequirementsPopover() {
            isShowingRequirementsPopover.toggle()
        }
        
        func cancel() {
            shouldDismiss = true
        }
        
        func create(context: ModelContext) {
            let genre = Genre(name: genreName, isFavorite: isFavorite, books: [])
            let dataHelper = DataHelper()
            let result = dataHelper.insert(context: context, model: genre)
            
            switch result {
            case .success(()):
                shouldDismiss = true
                return
            case .failure(_):
                context.rollback()
                isShowingError = true
            }
        }
    }
}
