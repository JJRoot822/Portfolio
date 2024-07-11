//
//  BrailleNumbersScreen.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BrailleNumbersScreen: View {
    @State private var numbers: [BrailleDictionaryEntry]?
    
    var body: some View {
        ZStack {
            if numbers == nil {
                ProgressView("Loading...")
            }
            
            if let numbers = numbers {
                BraillNumbersList(numbers: numbers)
            }
        }
        .task {
            let dictionary = await JSONHelper.loadData()
            self.numbers = dictionary?.numbers
        }
    }
}

