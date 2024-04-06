//
//  iPhoneApp.swift
//  BookBucket
//
//  Created by Joshua Root on 4/4/24.
//

import SwiftUI

struct iPhoneApp: View {
    @State private var selectedTab: AppSection = .home
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Home")
                .tabItem {
                    Label(NSLocalizedString(AppSection.home.rawValue, comment: ""), systemImage: "house.fill")
                }
            Text("Authors")
                .tabItem {
                    Label(NSLocalizedString(AppSection.authors.rawValue, comment: ""), systemImage: "person.3.fill")
                }
            Text("Genres")
                .tabItem {
                    Label(NSLocalizedString(AppSection.genres.rawValue, comment: ""), systemImage: "bookmark.fill")
                }
            Text("Books")
                .tabItem {
                    Label(NSLocalizedString(AppSection.books.rawValue, comment: ""), systemImage: "book.closed.fill")
                }
            Text("Book Lists")
                .tabItem {
                    Label(NSLocalizedString(AppSection.bookLists.rawValue, comment: ""), systemImage: "books.vertical.fill")
                }
            Text("Favorites")
                .tabItem {
                    Label(NSLocalizedString(AppSection.favorites.rawValue, comment: ""), systemImage: "star.fill")
                }
        }
    }
}

#Preview {
    iPhoneApp()
}
