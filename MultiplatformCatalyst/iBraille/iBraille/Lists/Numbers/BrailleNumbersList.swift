//
//  BrailleNumbersList.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BrailleNumbersList: View {
    var numbers: [BrailleDictionaryEntry]

    @State private var searchTerm: String = ""
    
    var filteredResults: [BrailleDictionaryEntry] {
        guard !searchTerm.isEmpty else {
            return numbers
        }
        
        return numbers.filter { $0.name.contains(searchTerm) }
    }
    
    var body: some View {
        List {
            ForEach(filteredResults, id: \.id) { number in
                SingleBrailleCellListCell(entry: number)
            }
        }
        .searchable(text: $searchTerm, prompt: Text("Search for a Number"))
        .overlay {
            if filteredResults.isEmpty {
                ContentUnavailableView.search(text: searchTerm)
            }
        }
    }
}

