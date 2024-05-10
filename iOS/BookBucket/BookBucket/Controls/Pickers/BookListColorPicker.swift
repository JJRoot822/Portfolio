//
//  BookListColorPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 4/30/24.
//

import SwiftUI

struct BookListColorPicker: View {
    @Binding var selection: String

    @State private var selectedIndex: Int
    
    private let options = Color.allColors.map {
        (name: $0.key, color: $0.value)
    }.sorted {
        $0.name < $1.name
    }
    
    private let columns = [
        GridItem(.adaptive(minimum: 50, maximum: 50))
    ]
    
    init(selection: Binding<String>) {
        self._selection = selection
        self._selectedIndex = State(wrappedValue: 0)
    }
    
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
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Select a color for your book list"))
        .accessibilityValue(LocalizedStringKey(selection))
        .accessibilityAdjustableAction { direction in
            if direction == .increment {
                if selectedIndex < options.count - 1 {
                    selectedIndex += 1
                }
            } else {
                if selectedIndex > 0 {
                    selectedIndex -= 1
                }
            }
        }
        .onChange(of: selectedIndex) {
            selection = options[selectedIndex].name
        }
    }
}
