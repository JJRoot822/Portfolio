//
//  AuthorSortOrderPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 3/8/24.
//

import SwiftUI



struct AuthorSortOrderPicker: View {
    @Binding var selection: AuthorSortCriteria
    
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
            Label("Author Sort Options", systemImage: "arrow.up.and.down")
        })
    }
}
