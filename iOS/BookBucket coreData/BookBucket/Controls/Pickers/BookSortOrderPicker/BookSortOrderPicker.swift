//
//  BookSortOrderPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 3/21/24.
//

import SwiftUI

struct BookSortOrderPicker: View {
    @Binding var selection: BookSortCriteria
    
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
            Label("Books Sort Options", systemImage: "arrow.up.and.down")
        })
    }
}
