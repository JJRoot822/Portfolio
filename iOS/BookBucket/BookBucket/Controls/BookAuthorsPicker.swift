//
//  BookAuthorsPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 3/19/24.
//

import SwiftUI
import SwiftData

struct BookAuthorsPicker: View {
    @Query private var authors: [Author]
    
    @Binding var selection: Set<Author>
    
    var body: some View {
        List(selection: $selection) {
            ForEach(authors) { author in
                Text("\(author.name)")
                    .tag(author)
            }
        }
    }
}
