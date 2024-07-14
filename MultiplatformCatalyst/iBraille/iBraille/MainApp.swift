//
//  MainApp.swift
//  iBraille
//
//  Created by Joshua Root on 7/13/24.
//

import SwiftUI

struct MainApp: View {
    @State private var selectedScreen: Int? = 0
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List(selection: $selectedScreen) {
                NavigationLink(value: 0) {
                    Label("Alphabet", systemImage: "characters.lowercase")
                }
                .keyboardShortcut("1", modifiers: [ .command ])
                
                NavigationLink(value: 1) {
                    Label("Numbers", systemImage: "numbers")
                }
                .keyboardShortcut("2", modifiers: [ .command ])
                
                NavigationLink(value: 2) {
                    Label("Contractions", systemImage: "characters.lowercase")
                }
                .keyboardShortcut("3", modifiers: [ .command ])
                
                NavigationLink(value: 3) {
                    Label("Short Form Words", systemImage: "characters.lowercase")
                }
                .keyboardShortcut("4", modifiers: [ .command ])
                
                NavigationLink(value: 4) {
                    Label("Punctuation & Indicators", systemImage: "bold.italic.underline")
                }
                .keyboardShortcut("5", modifiers: [ .command ])
            }
            .listStyle(.sidebar)
            .navigationTitle(Text("iBraille"))
        }, detail: {
            switch selectedScreen {
            case 0:
                BrailleAlphabetScreen()
                    .navigationTitle(Text("Alphabet"))
            case 1:
                BrailleNumbersScreen()
                    .navigationTitle(Text("Numbers"))
            case 2:
                BrailleContractionsScreen()
                    .navigationTitle(Text("Contractions"))
            case 3:
                BrailleShortFormWordsScreen()
                    .navigationTitle(Text("Short Form Words"))
            case 4:
                BraillePunctuationAndIndicatorsScreen()
                    .navigationTitle(Text("Punctuation"))
            default:
                EmptyView()
            }
        })
    }
}
