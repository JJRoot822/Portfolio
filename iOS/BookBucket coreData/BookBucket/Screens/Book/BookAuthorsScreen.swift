//
//  BookAuthorsScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI

struct BookAuthorsScreen: View {
    var authors: [Author]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(authors) { author in
                    Text(author.name)
                        .padding()
                }
            }
            .navigationTitle(Text("Book's Authors"))
        }
    }
}
