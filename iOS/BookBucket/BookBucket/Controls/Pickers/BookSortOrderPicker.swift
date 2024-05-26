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
                if selection == option {
                    Button(action: {
                        selection = option
                    }, label : {
                        Label(option.rawValue, systemImage: "checkmark")
                    })
                    .accessibilityLabel(Text("\(option.rawValue), selected"))
                } else {
                    Button(option.rawValue) {
                        selection = option
                    }
                    .accessibilityLabel(Text(option.rawValue))
                }
            }
        }, label: {
            Label("Books Sort Options", systemImage: "arrow.up.and.down")
        })
    }
}
