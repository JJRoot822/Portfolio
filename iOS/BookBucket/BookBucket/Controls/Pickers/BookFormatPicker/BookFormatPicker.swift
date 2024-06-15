//
//  BookFormatPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 3/19/24.
//

import SwiftUI

struct BookFormatPicker: View {
    @Binding var selection: String
    
    let viewModel = ViewModel()
    
    var body: some View {
        Picker("Book Format", selection: $selection) {
            ForEach(viewModel.options, id: \.self) { option in
                Text(option)
                    .tag(option.lowercased())
            }
        }
    }
}
