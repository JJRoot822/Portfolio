//
//  BrailleAlphabetList.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BraillAlphabetList: View {
    var letters: [BrailleDictionaryEntry]
    
    var body: some View {
        List {
            ForEach(letters, id: \.id) { letter in
                BrailleAlphabetListCell(entry: letter)
            }
        }
    }
}

