//
//  BookListsNavigationLink.swift
//  BookBucket
//
//  Created by Joshua Root on 4/4/24.
//

import SwiftUI

struct BookListsNavigationLink: View {
    var body: some View {
        NavigationLink(destination: {
            Text("Book Lists")
        }, label: {
            Label(NSLocalizedString(AppSection.bookLists.rawValue, comment: ""), systemImage: "books.vertical")
        })
    }
}
