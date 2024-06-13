//
//  BooksGrid+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/12/24.
//

import SwiftUI

extension BooksGrid {
    @Observable
    class ViewModel {
        let columns = [
            GridItem(.adaptive(minimum: 125, maximum: 150))
        ]
    }
}
