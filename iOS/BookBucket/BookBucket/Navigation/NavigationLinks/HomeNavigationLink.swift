//
//  HomeNavigationLink.swift
//  BookBucket
//
//  Created by Joshua Root on 4/4/24.
//

import SwiftUI

struct HomeNavigationLink: View {
    var body: some View {
        NavigationLink(destination: {
            Text("Home")
        }, label: {
            Label(NSLocalizedString(AppSection.home.rawValue, comment: ""), systemImage: "house")
        })
    }
}
