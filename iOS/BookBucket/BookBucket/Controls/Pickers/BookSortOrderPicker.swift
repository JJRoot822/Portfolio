//
//  BookSortOrderPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 3/21/24.
//

import SwiftUI

struct BookSortOrderPicker: View {
    @Binding var selection: BookSortCriteria
    
    private let options: [BookSortCriteria] = [
        .titleAscending, .titleDescending,
        .formatAscending, .formatDescending,
        .numberOfChaptersAscending, .numberOfChaptersDescending,
        .numberOfPagesAscending, .numberOfPagesDescending,
        .releaseDateAscending, .releaseDateDescending,
        .titleAscending, .titleDescending
    ]
    
    var body: some View {
        Menu(content: {
            ForEach(options, id: \.rawValue.self) { option in
                Button(option.rawValue) {
                    selection = option
                }
            }
        }, label: {
            Label("Books Sort Options", systemImage: "arrow.up.and.down")
        })
    }
}
