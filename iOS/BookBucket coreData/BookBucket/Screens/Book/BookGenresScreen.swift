//
//  BookGenresScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI

struct BookGenresScreen: View {
    var genres: [Genre]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(genres) { genre in
                    Text(genre.name)
                        .padding()
                }
            }
            .navigationTitle(Text("Book's Genres"))
        }
    }
}
