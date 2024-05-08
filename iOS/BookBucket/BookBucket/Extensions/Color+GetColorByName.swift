//
//  Color+GetColorByName.swift
//  BookBucket
//
//  Created by Joshua Root on 4/29/24.
//

import SwiftUI

extension Color {
    static let allColors: [String:Color] = [
        "Red": Color.red,
        "Green": Color.green,
        "Blue": Color.blue,
        "Yellow": Color.yellow, 
        "Orange": Color.orange,
        "Gray 1": Color(uiColor: .systemGray),
        "Gray 2": Color(uiColor: .systemGray2), 
        "Gray 3": Color(uiColor: .systemGray3),
        "Gray 4": Color(uiColor: .systemGray4),
        "Gray 5": Color(uiColor: .systemGray5),
        "Gray 6": Color(uiColor: .systemGray6),
        "Brown": Color.brown,
        "Cyan": Color.cyan,
        "Indigo": Color.indigo,
        "Mint": Color.mint,
        "Pink": Color.pink,
        "Purple": Color.purple,
        "Teal": Color.teal
    ]
    
    static func color(forName: String) -> Color {
        return allColors[forName] ?? Color.accentColor
    }
}
