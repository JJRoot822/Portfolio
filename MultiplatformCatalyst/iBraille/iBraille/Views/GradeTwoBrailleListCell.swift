//
//  GradeTwoBrailleListCell.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct GradeTwoBrailleListCell: View {
    var entry: BrailleDictionaryEntry
    
    var body: some View {
        HStack {
            if entry.spellOut {
                Text(entry.name)
                    .speechSpellsOutCharacters()
            } else {
                Text(entry.name)
            }
            
            Spacer()
            
            HStack(spacing: 25) {
                ForEach(entry.dotCombinations, id: \.self) { combination in
                    BrailleCell(
                        oneActive: containsDot(in: combination, 1),
                        twoActive: containsDot(in: combination, 2),
                        threeActive: containsDot(in: combination, 3),
                        fourActive: containsDot(in: combination, 4),
                        fiveActive: containsDot(in: combination,5),
                        sixActive: containsDot(in: combination, 6)
                    )
                }
            }
        }
        .accessibilityElement(children: .combine)
    }
    
    private func containsDot(in combination: [Int], _ dot: Int) -> Bool {
        return Set(combination).contains(dot)
    }
}


