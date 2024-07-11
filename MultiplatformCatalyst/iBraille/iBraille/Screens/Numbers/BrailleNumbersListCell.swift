//
//  BrailleNumbersListCell.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BrailleNumbersListCell: View {
    var entry: BrailleDictionaryEntry
    
    var body: some View {
        HStack {
            Text("\(entry.name)")
                .speechSpellsOutCharacters()
            
            Spacer()
            
            BrailleCell(
                oneActive: containsDot(in: entry.dotCombinations[0], 1),
                twoActive: containsDot(in: entry.dotCombinations[0], 2),
                threeActive: containsDot(in: entry.dotCombinations[0], 3),
                fourActive: containsDot(in: entry.dotCombinations[0], 4),
                fiveActive: containsDot(in: entry.dotCombinations[0],5),
                sixActive: containsDot(in: entry.dotCombinations[0], 6)
            )
        }
        .accessibilityElement(children: .combine)
    }
    
    private func containsDot(in combination: [Int], _ dot: Int) -> Bool {
        return Set(combination).contains(dot)
    }
}


