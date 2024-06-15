//
//  GenreSortOrderPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 3/10/24.
//

import SwiftUI

struct GenreSortOrderPicker: View {
    @Binding var selection: GenreSortCriteria
    
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
            Label("Genre Sort Options", systemImage: "arrow.up.and.down")
        })
    }
}
