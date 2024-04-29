//
//  AuthorsNavigationLink.swift
//  BookBucket
//
//  Created by Joshua Root on 4/4/24.
//

import SwiftUI

struct AuthorsNavigationLink: View {
    var body: some View {
        NavigationLink(destination: {
            Text("Authors")
        }, label: {
            Label(LocalizedStringKey(AppTab.authors.rawValue), systemImage: "person.3")
        })
    }
}
