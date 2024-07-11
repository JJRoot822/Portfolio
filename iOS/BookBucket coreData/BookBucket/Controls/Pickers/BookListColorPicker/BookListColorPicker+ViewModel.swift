//
//  BookListColorPicker+ViewModel.swift
//  BookBucket
//
//  Created by Joshua Root on 6/15/24.
//

import SwiftUI

extension BookListColorPicker {
    @Observable
    class ViewModel {
        var selectedIndex: Int
        
        init() {
            self.selectedIndex = 0
        }
        
        func getAllColors() -> [(name: String, color: Color)] {
            return Color.allColors.map {
                (name: $0.key, color: $0.value)
            }.sorted {
                $0.name < $1.name
            }
        }
        
        func performAdjustableAction(direction: AccessibilityAdjustmentDirection) {
            if direction == .increment {
                if selectedIndex < getAllColors().count - 1 {
                    selectedIndex += 1
                }
            } else {
                if selectedIndex > 0 {
                    selectedIndex -= 1
                }
            }
        }
        
        let columns = [
            GridItem(.adaptive(minimum: 50, maximum: 50))
        ]
    }
}
