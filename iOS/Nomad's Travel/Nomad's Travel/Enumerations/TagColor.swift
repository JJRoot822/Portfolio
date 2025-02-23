//
//  TagColor.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/21/25.
//

import UIKit

enum TagColor: String, CaseIterable {
    case ntBlue = "NTBlue", ntRed = "NTRed", ntCyan = "NTCyan", ntGold = "NTGold",
         ntGray = "NTGray", ntMint = "NTMint", ntPink = "NTPink", ntTeal = "NTTeal",
         ntBrown = "NTBrown", ntGreen = "NTGreen", ntIndigo = "NTIndigo", ntOrange = "NTOrange",
         ntPurple = "NTPurple", ntYellow = "NTYellow", ntMidnight = "NTMidnight", ntDarkBlue = "NTDarkBlue",
         ntDarkGray = "NTDarkGray", ntLightBlue = "NTLightBlue"
    
    static var allCases: [TagColor] {
        return [
            .ntBlue, .ntRed, .ntCyan, .ntGold,
            .ntGray, .ntMint, .ntPink, .ntTeal,
            .ntBrown, .ntGreen, .ntIndigo, .ntOrange,
            .ntPurple, .ntYellow, .ntMidnight, .ntDarkBlue,
            .ntDarkGray, .ntLightBlue
        ]
    }
    
    static func uiColors() -> [UIColor] {
        return [
            .ntBlue, .ntRed, .ntCyan, .ntGold,
            .ntGray, .ntMint, .ntPink, .ntTeal,
            .ntBrown, .ntGreen, .ntIndigo, .ntOrange,
            .ntPurple, .ntYellow, .ntMidnight, .ntDarkBlue,
            .ntDarkGray, .ntLightBlue
        ]
    }
    
    static func colorNames() -> [String] {
        return [
            "Blue", "Red", "Cyan", "Gold",
            "Gray", "Mint", "Pink", "Teal",
            "Brown", "Green", "Indigo", "Orange",
            "Purple", "Yellow", "Midnight", "Dark Blue",
            "Dark Gray", "Light Blue"
        ]
    }
    
    static func colorAssetNames() -> [String] {
        return [
            "NTBlue", "NTRed", "NTCyan", "NTGold",
            "NTGray", "NTMint", "NTPink", "NTTeal",
            "NTBrown", "NTGreen", "NTIndigo", "NTOrange",
            "NTPurple", "NTYellow", "NTMidnight", "NTDarkBlue",
            "NTDarkGray", "NTLightBlue"
        ]
    }
    
    static func colorName(for tagColor: TagColor) -> String {
        switch tagColor {
        case .ntBlue:
            return "Blue"
        case .ntRed:
            return "Red"
        case .ntCyan:
            return "Cyan"
        case .ntGold:
            return "Gold"
        case .ntGray:
            return "Gray"
        case .ntMint:
            return "Mint"
        case .ntPink:
            return "Pink"
        case .ntTeal:
            return "Teal"
        case .ntBrown:
            return "Brown"
        case .ntGreen:
            return "Green"
        case .ntIndigo:
            return "Indigo"
        case .ntOrange:
            return "Orange"
        case .ntPurple:
            return "Purple"
        case .ntYellow:
            return "Yellow"
        case .ntMidnight:
            return "Midnight"
        case .ntDarkBlue:
            return "Dark Blue"
        case .ntDarkGray:
            return "Dark Gray"
        case .ntLightBlue:
            return "Light Blue"
        }
    }
    
    static func uiColor(for tagColor: TagColor) -> UIColor {
        switch tagColor {
        case .ntBlue:
            return .ntBlue
        case .ntRed:
            return .ntRed
        case .ntCyan:
            return .ntCyan
        case .ntGold:
            return .ntGold
        case .ntGray:
            return .ntGray
        case .ntMint:
            return .ntMint
        case .ntPink:
            return .ntPink
        case .ntTeal:
            return .ntTeal
        case .ntBrown:
            return .ntBrown
        case .ntGreen:
            return .ntGreen
        case .ntIndigo:
            return .ntIndigo
        case .ntOrange:
            return .ntOrange
        case .ntPurple:
            return .ntPurple
        case .ntYellow:
            return .ntYellow
        case .ntMidnight:
            return .ntMidnight
        case .ntDarkBlue:
            return .ntDarkBlue
        case .ntDarkGray:
            return .ntDarkGray
        case .ntLightBlue:
            return .ntLightBlue
        }
    }
    
    static func uiColor(forAssetName: String) -> UIColor {
        return UIColor(named: forAssetName) ?? .clear
    }
    
    static func color(forAssetName: String) -> TagColor {
        for color in allCases {
            if color.rawValue == forAssetName {
                return color
            }
        }
        
        return .ntBlue
    }
    
    static func color(forColorName: String) -> TagColor {
        for color in allCases {
            if colorName(for: color) == forColorName {
                return color
            }
        }
        
        return .ntBlue
    }
    
    static func colorAssetName(for colorName: String) -> String {
        switch colorName {
        case "Blue":
            return "NTBlue"
        case "Red":
            return "NTRed"
        case "Cyan":
            return "NTCyan"
        case "Gold":
            return "NTGold"
        case "Gray":
            return "NTGray"
        case "Mint":
            return "NTMint"
        case "Pink":
            return "NTPink"
        case "Teal":
            return "NTTeal"
        case "Brown":
            return "NTBrown"
        case "Green":
            return "NTGreen"
        case "Indigo":
            return "NTIndigo"
        case "Orange":
            return "NTOrange"
        case "Purple":
            return "NTPurple"
        case "Yellow":
            return "NTYellow"
        case "Midnight":
            return "NTMidnight"
        case "Dark Blue":
            return "NTDarkBlue"
        case "Dark Gray":
            return "NTDarkGray"
        case "Light Blue":
            return "NTLightBlue"
        default:
            return "NTBlue"
        }
    }
}
