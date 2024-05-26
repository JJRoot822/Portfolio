//
//  BookListsSortCriteriaPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 4/6/24.
//

import SwiftUI

struct BookListsSortOrderPicker: View {
    @Binding var selection: BookListSortCriteria
    
    let options: [BookListSortCriteria] = [
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
            Label("Book Lists Sort Options", systemImage: "arrow.up.and.down")
        })
    }
}
