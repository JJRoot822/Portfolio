//
//  iPadApp.swift
//  BookBucket
//
//  Created by Joshua Root on 4/4/24.
//

import SwiftUI

struct iPadApp: View {
    var body: some View {
        NavigationSplitView(sidebar: {
            Sidebar()
        }, content: {
            Text("Nothing to See Right Now")
                .font(.system(.title))
                .foregroundStyle(Color.secondary)
        }, detail: {
            Text("Nothing to Show Right Now")
                .font(.system(.title3))
                .foregroundStyle(Color.secondary)
        })
    }
}

#Preview {
    iPadApp()
}
