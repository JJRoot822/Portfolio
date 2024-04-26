//
//  BrailleDictionary.swift
//  iBraille
//
//  Created by Joshua Root on 4/21/24.
//

import Foundation

struct BrailleDictionary: Decodable {
    var letters: [BrailleDictionaryEntry]
    var short_form_words: [BrailleDictionaryEntry]
    var contractions: [BrailleDictionaryEntry]
    var punctuation_and_indicators: [BrailleDictionaryEntry]
}
