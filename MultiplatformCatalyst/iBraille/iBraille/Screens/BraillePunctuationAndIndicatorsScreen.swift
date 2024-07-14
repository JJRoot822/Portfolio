//
//  BraillePunctuationAndIndicatorsScreen.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BraillePunctuationAndIndicatorsScreen: View {
    @State private var punctuation: [BrailleDictionaryEntry]?
    
    var body: some View {
        ZStack {
            if punctuation == nil {
                ProgressView("Loading...")
            }
            
            if let punctuation = punctuation {
                BraillePunctuationAndIndicatorsList(punctuation: punctuation)
            }
        }
        .task {
            let dictionary = await JSONHelper.loadData()
            self.punctuation = dictionary?.punctuationAndIndicators
        }
    }
}

