//
//  FavoritesScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 4/28/24.
//

import SwiftUI
import SwiftData

struct FavoritesCategoryPicker: View {
    @Binding var selection: Category
    
    private let options: [Category] = [ .authors, .genres, .books, .bookLists ]
    
    var body: some View {
        Picker("Favorites Category", selection: $selection) {
            ForEach(options, id: \.rawValue) { option in
                Text(LocalizedStringKey(option.rawValue))
                    .tag(option)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct FavoritesScreen: View {
    @State private var sortCriteria: FavoritesSortCriteria = .nameAscending
    @State private var selectedCategory: Category = .authors
    @State private var searchTerm: String = ""
    @State private var id: UUID = UUID()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                FavoritesCategoryPicker(selection: $selectedCategory)
                
                if selectedCategory == .authors {
                    FavoriteAuthorsList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                } else if selectedCategory == .books {
                    FavoriteBooksList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                } else if selectedCategory == .bookLists {
                    FavoriteBookListsList(sortCriteria: sortCriteria, searchTerm: searchTerm)
                }
            }
            .id(id)
            .navigationTitle(Text("Favorites"))
            .searchable(text: $searchTerm)
            .toolbar {
                FavoritesSortOrderPicker(selection: $sortCriteria)
            }
        }
    }
}

struct FavoriteBooksList: View {
    var body: some View {
        Text("")
    }
}
