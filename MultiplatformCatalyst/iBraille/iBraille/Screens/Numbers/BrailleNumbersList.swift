//
//  BrailleNumbersList.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BraillNumbersList: View {
    var numbers: [BrailleDictionaryEntry]
    
    var body: some View {
        List {
            ForEach(numbers, id: \.id) { number in
                BrailleNumbersListCell(entry: number)
            }
        }
    }
}

