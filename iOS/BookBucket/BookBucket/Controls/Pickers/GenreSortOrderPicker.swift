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
            Label("Genre Sort Options", systemImage: "arrow.up.and.down")
        })
    }
}
