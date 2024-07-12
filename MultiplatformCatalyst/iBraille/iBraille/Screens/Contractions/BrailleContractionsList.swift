//
//  BrailleNumbersList.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BrailleContractionsList: View {
    var contractions: [BrailleDictionaryEntry]
    
    var body: some View {
        List {
            ForEach(contractions, id: \.id) { contraction in
                GradeTwoBrailleListCell(entry: contraction)
            }
        }
    }
}

