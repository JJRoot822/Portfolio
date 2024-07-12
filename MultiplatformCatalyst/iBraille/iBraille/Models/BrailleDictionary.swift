//
//  BrailleDictionary.swift
//  iBraille
//
//  Created by Joshua Root on 7/10/24.
//

import Foundation

struct BrailleDictionary: Decodable {
    var letters: [BrailleDictionaryEntry]
    var numbers: [BrailleDictionaryEntry]
    var shortFormWords: [BrailleDictionaryEntry]
    var contractions: [BrailleDictionaryEntry]
    var punctuationAndIndicators: [BrailleDictionaryEntry]
}
