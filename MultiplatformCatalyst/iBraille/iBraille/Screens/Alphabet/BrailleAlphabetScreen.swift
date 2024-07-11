//
//  BrailleAlphabetScreen.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BrailleAlphabetScreen: View {
    @State private var letters: [BrailleDictionaryEntry]?
    
    var body: some View {
        ZStack {
            if letters == nil {
                ProgressView("Loading...")
            }
            
            if let letters = letters {
                BraillAlphabetList(letters: letters)
            }
            
            
        }
        .task {
            let dictionary = await JSONHelper.loadData()
            self.letters = dictionary?.letters
        }
    }
}

