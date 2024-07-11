//
//  BrailleCell.swift
//  iBraille
//
//  Created by Joshua Root on 7/10/24.
//

import SwiftUI

struct BrailleCell: View {
    var oneActive: Bool = false
    var twoActive: Bool = false
    var threeActive: Bool = false
    var fourActive: Bool = false
    var fiveActive: Bool = false
    var sixActive: Bool = false
    
    var accessibilityLabel: String {
        var dotStates = [ oneActive, twoActive, threeActive, fourActive, fiveActive, sixActive ]
        let activeDotsCount = dotStates.count { value in
            return value
        }
        
        if activeDotsCount == 0 {
            return "Empty Cell"
        } else if activeDotsCount == 1 {
            if oneActive { return "Dot 1" }
            if twoActive { return "Dot 2" }
            if threeActive { return "Dot 3" }
            if fourActive { return "Dot 4" }
            if fiveActive { return "Dot 5" }
            if sixActive { return "Dot 6" }
        } else {
            let activeDots: [Int] = dotStates.enumerated().filter { (index, value) in
                return value
            }.map { (index, _) in
                return index + 1
            }
            
            var label = "Dots "
            
            for (index, value) in activeDots.enumerated() {
                if index < (activeDots.count - 1) {
                    label += "\(value), "
                } else {
                    label += "\(value)"
                }
            }
            
            return label
        }
        
        return ""
    }
    
    var body: some View {
        HStack(spacing: 12.5) {
            VStack(spacing: 12.5) {
                Dot(active: oneActive)
                Dot(active: twoActive)
                Dot(active: threeActive)
            }
            
            VStack(spacing: 12.5) {
                Dot(active: fourActive)
                Dot(active: fiveActive)
                Dot(active: sixActive)
            }
        }
        .accessibilityElement()
        .accessibilityLabel(Text(accessibilityLabel))
    }
}
