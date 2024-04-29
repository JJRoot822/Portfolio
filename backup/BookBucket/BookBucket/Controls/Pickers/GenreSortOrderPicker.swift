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
        #if os(macOS) || os(visionOS)
        Picker(selection: $selection, content: {
            ForEach(options, id: \.rawValue.self) { option in
                Text("\(option.rawValue)")
                    .tag(option)
            }
        }, label: {
            Label("Genre Sort Options", systemImage: "arrow.up.and.down")
        })
#else
        Menu(content: {
            ForEach(options, id: \.rawValue.self) { option in
                Button(option.rawValue) {
                    selection = option
                }
            }
        }, label: {
            Label("Genre Sort Options", systemImage: "arrow.up.and.down")
        })
        #endif
    }
}
