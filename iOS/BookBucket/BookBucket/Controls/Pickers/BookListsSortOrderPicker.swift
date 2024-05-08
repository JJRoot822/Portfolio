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
                Button(option.rawValue) {
                    selection = option
                }
            }
        }, label: {
            Label("Book Lists Sort Options", systemImage: "arrow.up.and.down")
        })
    }
}
