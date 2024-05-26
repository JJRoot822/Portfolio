//
//  AuthorSortOrderPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 3/8/24.
//

import SwiftUI

struct AuthorSortOrderPicker: View {
    @Binding var selection: AuthorSortCriteria
    
    private let options: [AuthorSortCriteria] = [
        .nameAscending, .nameDescending,
        .booksAuthoredAscending, .booksAuthoredDescending
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
            Label("Author Sort Options", systemImage: "arrow.up.and.down")
        })
    }
}
