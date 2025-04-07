//
//  AllTagsView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/6/25.
//

import SwiftUI

struct AllTagsView: View {
	var body: some View {
		NavigationSplitView {
			AllTagsSidebarView()
		} content: {
			ContentUnavailableView("No Tag Selected", systemImage: "tag")
		} detail: {
			ContentUnavailableView("No Destination Selected", systemImage: "airplane")
		}
	}
}
