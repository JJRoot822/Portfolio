//
//  BookListsSortCriteriaPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 4/6/24.
//

import SwiftUI

struct BookListsSortOrderPicker: View {
    @Binding var selection: BookListSortCriteria
    
    let viewModel = ViewModel()
    
    var body: some View {
        Menu(content: {
            ForEach(viewModel.options, id: \.rawValue.self) { option in
                if selection == option {
                    Button(action: {
                        selection = option
                    }, label : {
                        Label(option.rawValue, systemImage: "checkmark")
                    })
                } else {
                    Button(option.rawValue) {
                        selection = option
                    }
                }
            }
        }, label: {
            Label("Book Lists Sort Options", systemImage: "arrow.up.and.down")
        })
    }
}
