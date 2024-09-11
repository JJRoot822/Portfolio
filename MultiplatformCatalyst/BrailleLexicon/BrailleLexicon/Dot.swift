//
//  Dot.swift
//  iBraille
//
//  Created by Joshua Root on 7/10/24.
//

import SwiftUI

struct Dot: View {
    var active: Bool = false
    var size: CGFloat
    
    var inactiveDot: some View {
        Circle()
            .stroke(Color(uiColor: .label))
            .frame(width: size, height: size)
    }
    
    var activeDot: some View {
        Circle()
            .fill(Color(uiColor: .label))
            .frame(width: size, height: size)
    }
    
    var body: some View {
        if active {
            activeDot
        } else {
            inactiveDot
        }
    }
}
