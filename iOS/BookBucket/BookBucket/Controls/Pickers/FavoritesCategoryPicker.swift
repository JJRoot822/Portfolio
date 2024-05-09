//
//  FavoritesCategoryPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 5/8/24.
//

import SwiftUI

struct FavoritesCategoryPicker: View {
    @Binding var selection: Category
    
    private let options: [Category] = [ .authors, .genres, .books, .bookLists ]
    
    var body: some View {
        Picker("Favorites Category", selection: $selection) {
            ForEach(options, id: \.rawValue.self) { option in
                Text(LocalizedStringKey(option.rawValue))
                    .tag(option)
            }
        }
        .pickerStyle(.segmented)
    }
}
