//
//  FavoritesCategoryPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 5/8/24.
//

import SwiftUI

struct FavoritesCategoryPicker: View {
    @Binding var selection: Category
    
    let viewModel = ViewModel()
    
    var body: some View {
        Picker("Favorites Category", selection: $selection) {
            ForEach(viewModel.options, id: \.rawValue.self) { option in
                Text(LocalizedStringKey(option.rawValue))
                    .tag(option)
            }
        }
        .pickerStyle(.segmented)
    }
}
