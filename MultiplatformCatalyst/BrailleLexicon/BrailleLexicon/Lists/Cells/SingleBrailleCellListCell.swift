//
//  SingleBrailleCellListCell.swift
//  iBraille
//
//  Created by Joshua Root on 7/12/24.
//

import SwiftUI

struct SingleBrailleCellListCell: View {
    var entry: BrailleDictionaryEntry
    
    var body: some View {
        HStack {
            if entry.spellOut {
                Text(entry.name)
                    .lineLimit(3)
                    .truncationMode(.tail)
                    .speechSpellsOutCharacters()
            } else {
                Text(entry.name)
                    .lineLimit(3)
                    .truncationMode(.tail)
            }
            
            Spacer()
                .frame(minWidth: 20)
            
            BrailleCell(
                dotSize: 30,
                oneActive: containsDot(in: entry.dotCombinations[0], 1),
                twoActive: containsDot(in: entry.dotCombinations[0], 2),
                threeActive: containsDot(in: entry.dotCombinations[0], 3),
                fourActive: containsDot(in: entry.dotCombinations[0], 4),
                fiveActive: containsDot(in: entry.dotCombinations[0],5),
                sixActive: containsDot(in: entry.dotCombinations[0], 6)
            )
        }
        .accessibilityElement(children: .combine)
        .padding(.all, 5)
    }
    
    private func containsDot(in combination: [Int], _ dot: Int) -> Bool {
        return Set(combination).contains(dot)
    }
}


