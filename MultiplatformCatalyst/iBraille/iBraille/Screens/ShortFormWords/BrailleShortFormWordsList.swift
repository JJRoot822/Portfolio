//
//  BrailleNumbersList.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BrailleShortFormWordsList: View {
    var shortFormWords: [BrailleDictionaryEntry]
    
    var body: some View {
        List {
            ForEach(shortFormWords, id: \.id) { word in
                GradeTwoBrailleListCell(entry: word)
            }
        }
    }
}

