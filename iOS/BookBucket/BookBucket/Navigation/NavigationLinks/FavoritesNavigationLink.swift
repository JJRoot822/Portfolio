//
//  FavoritesNavigationLink.swift
//  BookBucket
//
//  Created by Joshua Root on 4/4/24.
//

import SwiftUI

struct FavoritesNavigationLink: View {
    var body: some View {
        NavigationLink(destination: {
            Text("Favorites")
        }, label: {
            Label(NSLocalizedString(AppSection.favorites.rawValue, comment: ""), systemImage: "star")
        })
    }
}
