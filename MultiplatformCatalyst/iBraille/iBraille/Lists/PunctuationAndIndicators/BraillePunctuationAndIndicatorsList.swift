//
//  BraillePunctuationAndIndicatorsList.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BraillePunctuationAndIndicatorsList: View {
    var punctuation: [BrailleDictionaryEntry]

    @State private var searchTerm: String = ""
    
    var filteredResults: [BrailleDictionaryEntry] {
        guard !searchTerm.isEmpty else {
            return punctuation
        }
        
        return punctuation.filter { $0.name.contains(searchTerm) }
    }
    
    var body: some View {
        List {
            ForEach(filteredResults, id: \.id) { punctuation in
                if punctuation.dotCombinations.count > 1 {
                    MultipleBrailleCellsListCell(entry: punctuation)
                } else {
                    SingleBrailleCellListCell(entry: punctuation)
                }
            }
        }
        .searchable(text: $searchTerm, prompt: Text("Search for an Indicator or Punctuation"))
        .overlay {
            if filteredResults.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            }
        }
    }
}

