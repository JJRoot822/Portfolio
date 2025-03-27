//
//  TagColors.swift
//  NomadTravel
//
//  Created by Joshua Root on 2/26/25.
//

import UIKit

struct TagColor: Identifiable {
    let id = UUID()
    var name: String
    var resourceName: String
    var color: UIColor
}

class TagColors {
    static let red = TagColor(name: "Red", resourceName: "NTRed", color: .ntRed)
    static let blue = TagColor(name: "Blue", resourceName: "NTBlue", color: .ntBlue)
    static let cyan = TagColor(name: "Cyan", resourceName: "NTCyan", color: .ntCyan)
    static let gold = TagColor(name: "Gold", resourceName: "NTGold", color: .ntGold)
    static let green = TagColor(name: "Green", resourceName: "NTGreen", color: .ntGreen)
    static let gray = TagColor(name: "Gray", resourceName: "NTGray", color: .ntGray)
    static let mint = TagColor(name: "Mint", resourceName: "NTMint", color: .ntMint)
    static let pink = TagColor(name: "Pink", resourceName: "NTPink", color: .ntPink)
    static let teal = TagColor(name: "Teal", resourceName: "NTTeal", color: .ntTeal)
    static let brown = TagColor(name: "Brown", resourceName: "NTBrown", color: .ntBrown)
    static let indigo = TagColor(name: "Indigo", resourceName: "NTIndigo", color: .ntIndigo)
    static let orange = TagColor(name: "Orange", resourceName: "NTOrange", color: .ntOrange)
    static let darkGray = TagColor(name: "Dark Gray", resourceName: "NTDarkGray", color: .ntDarkGray)
    static let darkBlue = TagColor(name: "Dark Blue", resourceName: "NTDarkBlue", color: .ntDarkBlue)
    static let midnight = TagColor(name: "Midnight", resourceName: "NTMidnight", color: .ntMidnight)
    static let lightBlue = TagColor(name: "Light Blue", resourceName: "NTLightBlue", color: .ntLightBlue)
    static let purple = TagColor(name: "Purple", resourceName: "NTPurple", color: .ntPurple)
    static let yellow = TagColor(name: "Yellow", resourceName: "NTYellow", color: .ntYellow)
}
