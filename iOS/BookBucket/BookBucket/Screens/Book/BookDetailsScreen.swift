//
//  BookDetailsScreen.swift
//  BookBucket
//
//  Created by Joshua Root on 5/23/24.
//

import SwiftUI

struct BookDetailsScreen: View {
    var book: Book
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let data = book.coverImage,
                   let image = UIImage(data: data) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }
                
                
            }
        }
    }
}
