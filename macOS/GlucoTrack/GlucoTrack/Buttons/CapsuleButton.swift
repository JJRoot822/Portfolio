//
//  CapsuleButton.swift
//  GlucoTrack
//
//  Created by Joshua Root on 8/6/24.
//

import SwiftUI

struct CapsuleButton: View {
    var title: String
    var disable: Bool
    var action: (() -> Void)
    
    init(_ title: String, disable: Bool, action: @escaping (() -> Void)) {
        self.title = title
        self.disable = disable
        self.action = action
    }
    
    var body: some View {
        ZStack {
            Capsule()
                .padding(.horizontal, 175)
                .padding(.vertical, 50)
                .foregroundStyle(disable ? Color.gray.gradient : Color.blue.gradient)
        }
        .onTapGesture(perform: action)
        .accessibilityElement()
        .accessibilityLabel(Text(title))
    }
}
