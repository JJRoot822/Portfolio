//
//  IconButton.swift
//  BookBucket
//
//  Created by Joshua Root on 3/7/24.
//

import SwiftUI

struct IconButton: View {
    var title: LocalizedStringKey
    var icon: String
    var backgroundColor: Color?
    var foregroundColor: Color?
    var action: (() -> Void)
    
    var body: some View {
        if let backgroundColor = backgroundColor, let foregroundColor = foregroundColor {
            Button(action: action) {
                Label(title, systemImage: icon)
            }
            .foregroundStyle(foregroundColor)
            .background(backgroundColor)
        } else {
            Button(action: action) {
                Label(title, systemImage: icon)
            }
        }
    }
}
