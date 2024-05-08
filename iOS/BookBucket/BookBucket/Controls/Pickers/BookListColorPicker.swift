//
//  BookListColorPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 4/30/24.
//

import SwiftUI

struct BookListColorPicker: View {
    @Binding var selection: String
    
    private let options = Color.allColors.map {
        (name: $0.key, color: $0.value)
    }
    
    private let columns = [
        GridItem(.adaptive(minimum: 50, maximum: 50))
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(options, id: \.name.self) { option in
                BookListColorPickerItem(color: option.color,
                                        label: LocalizedStringKey(option.name),
                                        selected: selection == option.name)
                .onTapGesture {
                    selection = option.name
                }
            }
        }
    }
}
