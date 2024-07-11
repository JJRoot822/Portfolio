//
//  ContentView.swift
//  iBraille
//
//  Created by Joshua Root on 7/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedScreen: Int? = 0
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List(selection: $selectedScreen) {
                NavigationLink(value: 0) {
                    Text("Alphabet")
                }
                
                NavigationLink(value: 1) {
                    Text("Numbers")
                }
                
                NavigationLink(value: 2) {
                    Text("Contractions")
                }
                
                NavigationLink(value: 3) {
                    Text("Short Form Words")
                }
                
                NavigationLink(value: 4) {
                    Text("Punctuation & Indicators")
                }
                
                NavigationLink(value: 5) {
                    Text("Math Symbols")
                }
            }
            .listStyle(.sidebar)
        }, detail: {
            switch selectedScreen {
            case 0:
                BrailleAlphabetScreen()
            case 1:
                BrailleNumbersScreen()
            // case 2:
                // BrailleContractionsScreen()
            // case 3:
                // BrailleShortFormWordsScreen()
            // case 4:
                // BraillePunctuationAndIndicatorsScreen()
            // case 5:
                // BrailleMathSymbolsScreen()
            default:
                EmptyView()
            }
        })
    }
}

