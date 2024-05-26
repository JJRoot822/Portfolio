//
//  FavoritesSortOrderPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 4/28/24.
//

import SwiftUI

struct FavoritesSortOrderPicker: View {
    @Binding var selection: FavoritesSortCriteria
    
    private let options: [FavoritesSortCriteria] = [
        .nameAscending, .nameDescending
    ]
    
    var body: some View {
        Menu(content: {
            ForEach(options, id: \.rawValue) { option in
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
            Label("Favorites Sort Order", systemImage: "arrow.up.and.down")
                .labelStyle(.iconOnly)
        })
    }
}
