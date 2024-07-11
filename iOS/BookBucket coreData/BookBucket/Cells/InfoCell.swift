//
//  InfoCell.swift
//  BookBucket
//
//  Created by Joshua Root on 5/28/24.
//

import SwiftUI

struct InfoCell: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
            
            Spacer()
            
            Text(value)
                .foregroundStyle(Color.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}
