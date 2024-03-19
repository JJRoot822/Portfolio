//
//  GenreSortOrderPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 3/10/24.
//

import SwiftUI

struct GenreSortOrderPicker: View {
    @Binding var selection: GenreSortCriteria
    
    private let options: [GenreSortCriteria] = [
        .nameAscending, .nameDescending,
        .numberOfBooksAscending, .numberOfBooksDescending
    ]
    
    var body: some View {
        Picker(selection: $selection, content: {
            ForEach(options, id: \.rawValue.self) { option in
                Text("\(option.rawValue)")
                    .tag(option)
            }
        }, label: {
            Label("Sort Options", systemImage: "arrow.up.and.down")
        })
        .labelsHidden()
    }
}
