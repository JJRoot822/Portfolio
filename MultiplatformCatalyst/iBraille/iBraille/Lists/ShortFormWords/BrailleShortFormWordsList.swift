//
//  BrailleShortFormWordsList.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BrailleShortFormWordsList: View {
    var shortFormWords: [BrailleDictionaryEntry]

    @State private var searchTerm: String = ""
    
    var filteredResults: [BrailleDictionaryEntry] {
        guard !searchTerm.isEmpty else {
            return shortFormWords
        }
        
        return shortFormWords.filter { $0.name.contains(searchTerm) }
    }
    
    var body: some View {
        List {
            ForEach(filteredResults, id: \.id) { word in
                if word.dotCombinations.count > 1 {
                    MultipleBrailleCellsListCell(entry: word)
                } else {
                    SingleBrailleCellListCell(entry: word)
                }
            }
        }
        .searchable(text: $searchTerm, prompt: Text("Search for a Short Form Word"))
        .overlay {
            if filteredResults.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            }
        }
    }
}

