//
//  BrailleShortFormWordsScreen.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BrailleShortFormWordsScreen: View {
    @State private var shortFormWords: [BrailleDictionaryEntry]?
    
    var body: some View {
        ZStack {
            if shortFormWords == nil {
                ProgressView("Loading...")
            }
            
            if let shortFormWords = shortFormWords {
                BrailleShortFormWordsList(shortFormWords: shortFormWords)
            }
        }
        .task {
            let dictionary = await JSONHelper.loadData()
            self.shortFormWords = dictionary?.shortFormWords
        }
    }
}

