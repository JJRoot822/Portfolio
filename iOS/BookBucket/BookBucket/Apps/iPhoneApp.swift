//
//  iPhoneApp.swift
//  BookBucket
//
//  Created by Joshua Root on 4/24/24.
//

import SwiftUI

struct iPhoneApp: View {
    @Environment(\.modelContext) var context
    
    @State private var selectedTab: AppTab = .books
    
    var body: some View {
        TabView(selection: $selectedTab) {
            BooksScreen()
                .tag(AppTab.books)
                .tabItem {
                    Label(NSLocalizedString(AppTab.books.rawValue, comment: ""), systemImage: "book.closed.fill")
                }
            
            BookListsScreen()
                .tag(AppTab.bookLists)
                .tabItem {
                    Label(NSLocalizedString(AppTab.bookLists.rawValue, comment: ""), systemImage: "books.vertical.fill")
                }
            
            FavoritesScreen()
                .tag(AppTab.favorites)
                .tabItem {
                    Label(NSLocalizedString(AppTab.favorites.rawValue, comment: ""), systemImage: "star.fill")
                }
            
            GenresScreen()
                .tag(AppTab.genres)
                .tabItem {
                    Label(NSLocalizedString(AppTab.genres.rawValue, comment: ""), systemImage: "bookmark.fill")
                }
            
            AuthorsScreen()
                .tag(AppTab.authors.rawValue)
                .tabItem {
                    Label(NSLocalizedString(AppTab.authors.rawValue, comment: ""), systemImage: "person.fill")
                }
            
            
        }
    }
}
