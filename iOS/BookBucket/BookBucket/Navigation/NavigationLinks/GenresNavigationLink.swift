//
//  GenresNavigationLink.swift
//  BookBucket
//
//  Created by Joshua Root on 4/4/24.
//

import SwiftUI

struct GenresNavigationLink: View {
    var body: some View {
        NavigationLink(destination: {
            
        }, label: {
            Label(NSLocalizedString(AppSection.genres.rawValue, comment: ""), systemImage: "bookmark")
        })
    }
}
