//
//  BookListColorPickerItem.swift
//  BookBucket
//
//  Created by Joshua Root on 4/30/24.
//

import SwiftUI

struct BookListColorPickerItem: View {
    var color: Color
    var label: String
    var selected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundStyle(color.gradient)
            
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(color.gradient)
                .background(Color(uiColor: .systemBackground))
                .clipShape(Circle())
                .opacity(selected ? 1 : 0)
        }
        .shadow(color: .black, radius: 10, x: 0, y: 0)
    }
}
