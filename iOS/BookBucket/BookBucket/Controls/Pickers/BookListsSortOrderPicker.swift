//
//  BookListsSortCriteriaPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 4/6/24.
//

import SwiftUI

struct BookListsSortCriteriaPicker: View {
    @Binding var selection: BookListSortCriteria
    
    let options: [BookListSortCriteria] = [
        .nameAscending, .nameDescending,
        .numberOfBooksAscending, .numberOfBooksDescending
    ]
    
    var body: some View {
        #if os(macOS) || os(visionOS)
        Picker(selection: $selection, content: {
            ForEach(options, id: \.rawValue.self) { option in
                Text(option.rawValue)
                    .tag(option)
            }
        }, label: {
            Label("Book Lists Sort Options", systemImage: "arrow.up.and.down")
        })
        #else
        Menu(content: {
            ForEach(options, id: \.rawValue.self) { option in
                Button(option.rawValue) {
                    selection = option
                }
            }
        }, label: {
            Label("Book Lists Sort Options", systemImage: "arrow.up.and.down")
        })
        #endif
    }
}
