//
//  BookListColorPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 4/30/24.
//

import SwiftUI

struct BookListColorPicker: View {
    @Binding var selection: String

    @State private var viewModel: ViewModel
    
    init(selection: Binding<String>) {
        let viewModel = ViewModel()
        viewModel.selectedIndex = 0
        
        self._selection = selection
        self._viewModel = State(wrappedValue: viewModel)
    }
    
    var body: some View {
        LazyVGrid(columns: viewModel.columns, spacing: 20) {
            ForEach(viewModel.getAllColors(), id: \.name.self) { option in
                BookListColorPickerItem(color: option.color,
                                        label: option.name,
                                        selected: selection == option.name)
                .onTapGesture {
                    selection = option.name
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(Text("Select a color for your book list"))
        .accessibilityValue(selection)
        .accessibilityAdjustableAction(viewModel.performAdjustableAction)
        .onChange(of: viewModel.selectedIndex) {
            selection = viewModel.getAllColors()[viewModel.selectedIndex].name
        }
    }
}
