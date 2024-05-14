//
//  FieldInfoPopover.swift
//  BookBucket
//
//  Created by Joshua Root on 5/10/24.
//

import SwiftUI

struct FieldInfoPopover: View {
    @Environment(\.dismiss) var dismiss
    
    var infoText: LocalizedStringKey
    
    var body: some View {
        VStack {
            Text(infoText)
         
            HStack {
                Spacer()
                
                Button("Close") {
                    dismiss()
                }
            }
        }
        .padding()
    }
}
