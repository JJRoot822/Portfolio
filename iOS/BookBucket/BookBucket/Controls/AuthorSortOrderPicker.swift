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
