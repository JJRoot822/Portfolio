//
//  ContentView.swift
//  iBraille
//
//  Created by Joshua Root on 7/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedScreen: Int? = 0
    
    var body: some View {
        TabView(selection: $selectedScreen) {
            Tab("Alphabet", systemImage: "characters.lowercase", value: 1) {
                BrailleAlphabetScreen()
            }
            
            Tab("Numbers", systemImage: "numbers", value: 2) {
                BrailleNumbersScreen()
            }
            
            Tab("Contractions", systemImage: "characters.lowercase", value: 3) {
                BrailleContractionsScreen()
            }
            
            Tab("Short Form Words", systemImage: "characters.lowercase", value: 4) {
                BrailleShortFormWordsScreen()
            }
            
            Tab("Punctuation and Indicators", systemImage: "bold.italic.underline", value: 5) {
                BraillePunctuationAndIndicatorsScreen()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
        NavigationSplitView(sidebar: {
            List(selection: $selectedScreen) {
                
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
