//
//  BrailleDictionaryEntry.swift
//  iBraille
//
//  Created by Joshua Root on 4/21/24.
//

import Foundation

struct BrailleDictionaryEntry: Decodable {
    var name: String
    var dot_combinations: [Int]
}
