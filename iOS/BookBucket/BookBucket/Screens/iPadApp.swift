//
//  iPadApp.swift
//  BookBucket
//
//  Created by Joshua Root on 6/11/24.
//

import SwiftUI

struct iPadApp: View {
    @State private var selectedScreen: AppTab? = .books
    
    var body: some View {
        NavigationSplitView {
            Sidebar(selection: $selectedScreen)
        } detail: {
            if let selectedScreen = selectedScreen {
                switch selectedScreen {
                case .books:
                    BooksScreen()
                case .bookLists:
                    BookListsScreen()
                case .favorites:
                    FavoritesScreen()
                case .genres:
                    GenresScreen()
                case .authors:
                    AuthorsScreen()
                }
            }
        }
    }
}
