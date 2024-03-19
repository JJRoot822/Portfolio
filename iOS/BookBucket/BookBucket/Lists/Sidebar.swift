//
//  Sidebar.swift
//  BookBucket
//
//  Created by Joshua Root on 3/19/24.
//

import SwiftUI

struct Sidebar: View {
    var body: some View {
        List {
            NavigationLink(destination: AuthorsListScreen.init) {
                Label("Authors", systemImage: "person")
            }
            .padding()
            
            NavigationLink(destination: GenresListScreen.init) {
                Label("Genres", systemImage: "bookmark")
            }
            .padding()
            
//            NavigationLink(destination: {
//
//            }, label: {
//                Label("Books", systemImage: "book.closed")
//            })
//
//            NavigationLink(destination: {
//
//            }, label: {
//                Label("Book Lists", systemImage: "books.vertical")
//            })
        }
        .navigationTitle(Text("BookBucket"))
    }
}
