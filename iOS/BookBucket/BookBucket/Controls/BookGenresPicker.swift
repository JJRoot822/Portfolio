//
//  BookGenresPicker.swift
//  BookBucket
//
//  Created by Joshua Root on 3/19/24.
//

import SwiftUI
import SwiftData

struct BookGenresPicker: View {
    @Query private var genres: [Genre]
    
    @Binding var selection: Set<Genre>
    
    var body: some View {
        List(selection: $selection) {
            ForEach(genres) { genre in
                Text("\(genre.name)")
                    .tag(genre)
            }
        }
    }
}
