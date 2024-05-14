//
//  FieldInfoPopoverToggleButton.swift
//  BookBucket
//
//  Created by Joshua Root on 5/10/24.
//

import SwiftUI

struct FieldInfoPopoverToggleButton: View {
    var label: LocalizedStringKey
    var action: (() -> Void)
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "info.circle")
        }
        .accessibilityLabel(Text(label))
    }
}
