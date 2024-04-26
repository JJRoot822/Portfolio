//
//  iPhoneApp.swift
//  BookBucket
//
//  Created by Joshua Root on 4/24/24.
//

import SwiftUI

enum AppTab: String {
    case home = "Home"
    case books = "Books"
    case bookLists = "Book Lists"
    case favorites = "Favorites"
    case genres = "Genres"
    case authors = "Authors"
}

struct iPhoneApp: View {
    @State private var selectedTab: AppTab = .home
    
    var body: some View {
        TabView {
            HomeScreen()
                .tag(AppTab.home)
                .tabItem {
                    Label(NSLocalizedString(AppTab.home.rawValue, comment: ""), systemImage: "house.fill")
                }
            
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

struct HomeScreen: View {
    var body: some View {
        Text("")
    }
}

struct BooksScreen: View {
    var body: some View {
        Text("")
    }
}

struct BookListsScreen: View {
    var body: some View {
        Text("")
    }
}

struct FavoritesScreen: View {
    var body: some View {
        Text("")
    }
}
