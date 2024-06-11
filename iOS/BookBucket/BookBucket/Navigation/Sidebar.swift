//
//  Sidebar.swift
//  BookBucket
//
//  Created by Joshua Root on 4/4/24.
//

import SwiftUI

struct Sidebar: View {
    @Binding var selection: AppTab?
    
    var body: some View {
        List(selection: $selection) {
            NavigationLink(value: AppTab.books) {
                Label(AppTab.books.rawValue, systemImage: "book.closed")
            }
            
            NavigationLink(value: AppTab.bookLists) {
                Label(AppTab.bookLists.rawValue, systemImage: "books.vertical")
            }
            
            NavigationLink(value: AppTab.favorites) {
                Label(AppTab.favorites.rawValue, systemImage: "star.fill")
            }
            
            NavigationLink(value: AppTab.authors) {
                Label(AppTab.authors.rawValue, systemImage: "person.3")
            }
            
            NavigationLink(value: AppTab.genres) {
                Label(AppTab.genres.rawValue, systemImage: "bookmark.fill")
            }
        }
        .listStyle(.sidebar)
    }
}
