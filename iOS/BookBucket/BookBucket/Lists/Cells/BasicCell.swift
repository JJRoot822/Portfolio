//
//  BasicListCell.swift
//  BookBucket
//
//  Created by Joshua Root on 4/6/24.
//

import SwiftUI

struct BasicListCell: View {
    var primaryText: String
    var secondaryText: String?
    var leadingEdgeSymbol: String?
    var boldTitle: Bool
    
    init(title: String, boldTitle: Bool) {
        self.primaryText = title
        self.boldTitle = boldTitle
    }
    
    init(title: String, icon: String, boldTitle: Bool) {
        self.primaryText = title
        self.leadingEdgeSymbol = icon
        self.boldTitle = boldTitle
    }
    
    init(title: String, subtitle: String, boldTitle: Bool) {
        self.primaryText = title
        self.secondaryText = subtitle
        self.boldTitle = boldTitle
    }
    
    init(title: String, subtitle: String, icon: String, boldTitle: Bool) {
        self.primaryText = title
        self.secondaryText = subtitle
        self.leadingEdgeSymbol = icon
        self.boldTitle = boldTitle
    }
    
    var body: some View {
        HStack(spacing: 10) {
            if let icon = leadingEdgeSymbol {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading) {
                if boldTitle {
                    Text(primaryText)
                        .bold()
                } else {
                    Text(primaryText)
                }
                
                if let subtitle = secondaryText {
                    Text(subtitle)
                        .foregroundStyle(Color.secondary)
                }
            }
        }
    }
}
