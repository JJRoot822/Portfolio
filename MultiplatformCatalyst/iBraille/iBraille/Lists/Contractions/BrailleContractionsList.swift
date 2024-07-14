//
//  BrailleContractionsList.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BrailleContractionsList: View {
    var contractions: [BrailleDictionaryEntry]
    
    @State private var searchTerm: String = ""
    
    var filteredResults: [BrailleDictionaryEntry] {
        guard !searchTerm.isEmpty else {
            return contractions
        }
        
        return contractions.filter { $0.name.contains(searchTerm) }
    }
    
    var body: some View {
        List {
            ForEach(filteredResults, id: \.id) { contraction in
                if contraction.dotCombinations.count > 1 {
                    MultipleBrailleCellsListCell(entry: contraction)
                } else {
                    SingleBrailleCellListCell(entry: contraction)
                }
            }
        }
        .searchable(text: $searchTerm, prompt: Text("Search for a Contraction"))
        .overlay {
            if filteredResults.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            }
        }
    }
}

