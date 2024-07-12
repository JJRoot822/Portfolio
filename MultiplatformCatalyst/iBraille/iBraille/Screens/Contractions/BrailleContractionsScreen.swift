//
//  BrailleContractionsScreen.swift
//  iBraille
//
//  Created by Joshua Root on 7/11/24.
//

import SwiftUI

struct BrailleContractionsScreen: View {
    @State private var contractions: [BrailleDictionaryEntry]?
    
    var body: some View {
        ZStack {
            if contractions == nil {
                ProgressView("Loading...")
            }
            
            if let contractions = contractions {
                BrailleContractionsList(contractions: contractions)
            }
        }
        .task {
            let dictionary = await JSONHelper.loadData()
            self.contractions = dictionary?.contractions
        }
    }
}

