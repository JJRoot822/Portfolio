//
//  GradeTwoBrailleListCell.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct MultipleBrailleCellsListCell: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var entry: BrailleDictionaryEntry

    var dotSize: CGFloat {
        switch (horizontalSizeClass, verticalSizeClass) {
        case (.compact, .regular):
            if entry.dotCombinations.count > 3 {
                return 5
            }
            
            if entry.dotCombinations.count == 3 {
                return 10
            }
            
            return 15
        case (.compact, .compact):
            if entry.dotCombinations.count > 3 {
                return 5
            }
            
            if entry.dotCombinations.count == 3 {
                return 10
            }
            
            return 15
        case (.regular, .compact):
            if entry.dotCombinations.count > 3 {
                return 5
            }
            
            if entry.dotCombinations.count == 3 {
                return 10
            }
            
            return 15
        case (.regular, .regular):
            if entry.dotCombinations.count > 2 {
                return 20
            }
            
            return 30
        default:
            return 25
        }
    }
    
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
            
            HStack(spacing: 25) {
                ForEach(entry.dotCombinations, id: \.self) { combination in
                    BrailleCell(
                        dotSize: horizontalSizeClass == .compact ? 15 : 20,
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
        .padding(.all, 5)
        .accessibilityElement(children: .combine)
    }
    
    private func containsDot(in combination: [Int], _ dot: Int) -> Bool {
        return Set(combination).contains(dot)
    }
}


