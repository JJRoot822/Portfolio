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
            ForEach(options, id: \.rawValue.self) { option in
                Button(LocalizedStringKey(option.rawValue)) {
                    selection = option
                }
            }
        }, label: {
            Label("Favorites Sort Options", systemImage: "arrow.up.and.down")
        }
    }
}
