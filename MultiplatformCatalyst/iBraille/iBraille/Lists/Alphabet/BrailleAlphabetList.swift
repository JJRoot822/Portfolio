//
//  BrailleAlphabetList.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BraillAlphabetList: View {
    var letters: [BrailleDictionaryEntry]

    @State private var searchTerm: String = ""
    
    var filteredResults: [BrailleDictionaryEntry] {
        guard !searchTerm.isEmpty else {
            return letters
        }
        
        return letters.filter { $0.name.contains(searchTerm) }
    }
    
    var body: some View {
        List {
            ForEach(filteredResults, id: \.id) { letter in
                SingleBrailleCellListCell(entry: letter)
            }
        }
        .searchable(text: $searchTerm, prompt: Text("Search for a Letter"))
        .overlay {
            if filteredResults.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            }
        }
    }
}

