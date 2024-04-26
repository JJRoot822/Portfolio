//
//  Sidebar.swift
//  BookBucket
//
//  Created by Joshua Root on 4/4/24.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            HomeNavigationLink()
            AuthorsNavigationLink()
            GenresNavigationLink()
            BooksNavigationLink()
            BookListsNavigationLink()
            FavoritesNavigationLink()
        }
        .listStyle(.sidebar)
        .navigationTitle(Text(NSLocalizedString("BookBucket", comment: "")))
    }
}
