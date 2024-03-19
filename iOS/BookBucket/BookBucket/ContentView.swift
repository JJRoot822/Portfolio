//
//  ContentView.swift
//  BookBucket
//
//  Created by Joshua Root on 2/20/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        if UIDevice.current.userInterfaceIdiom == .pad || UIDevice.current.userInterfaceIdiom == .mac {
            NavigationSplitView(sidebar: {
                Sidebar()
                    .listStyle(.sidebar)
            }, content: {
                ContentUnavailableView("Nothing to Show Right Now. Please Select an Option From the Sidebar.", systemImage: "book")
            }, detail: {
                
            })
        } else {
            NavigationStack {
                Sidebar()
            }
        }
    }
}
