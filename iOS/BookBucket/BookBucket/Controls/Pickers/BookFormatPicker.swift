//
//  BookFormatPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 3/19/24.
//

import SwiftUI

struct BookFormatPicker: View {
    @Binding var selection: String
    
    private let options: [String] = [
        "Print", "eBook", "Audiobook", "large Print", "Braille (Digital)", "Braille (Physical)"
    ]
    
    var body: some View {
        Picker("Book Format", selection: $selection) {
            ForEach(options, id: \.self) { option in
                Text(option)
                    .tag(option.lowercased())
            }
        }
    }
}
