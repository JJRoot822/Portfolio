//
//  TagCellContentView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/6/25.
//

import SwiftUI

struct TagCellContentView: View {
	var tag: Tag
	
	var body: some View {
		HStack {
			Circle()
				.fill(Color(tag.color))
			
			Text(tag.title)
		}
	}
}

