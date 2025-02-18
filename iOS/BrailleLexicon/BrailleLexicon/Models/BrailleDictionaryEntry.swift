//
//  BrailleDictionaryEntry.swift
//  iBraille
//
//  Created by Joshua Root on 7/10/24.
//

import Foundation

struct BrailleDictionaryEntry: Decodable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var dotCombinations: [[Int]]
    var spellOut: Bool
}
