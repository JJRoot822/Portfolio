//
//  BooksNavigationLink.swift
//  BookBucket
//
//  Created by Joshua Root on 4/4/24.
//

import SwiftUI

struct BooksNavigationLink: View {
    var body: some View {
        NavigationLink(destination: {
            Text("Books")
        }, label: {
            Label(NSLocalizedString(AppSection.books.rawValue, comment: ""), systemImage: "book.closed")
        })
    }
}
