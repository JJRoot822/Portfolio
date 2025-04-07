//
//  TagCellView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/6/25.
//

import SwiftUI

struct TagCellView: View {
	@Environment(\.modelContext) var context
	
	@State private var isShowingEditTagView: Bool = false
	@State private var isShowingDeleteError: Bool = false
	
	var tag: Tag
	
	var body: some View {
		NavigationLink {
			AllTaggedDestinationsListView(tag: tag)
		} label: {
			TagCellContentView(tag: tag)
		}
		.swipeActions(edge: .trailing, allowsFullSwipe: false) {
			Button(role: .destructive) {
				delete(tag: tag)
			} label: {
				Label("Delete", systemImage: "trash")
			}
			.alert(Constants.deleteTagErrorTitle, isPresented: $isShowingDeleteError) {
				Button("OK") {
					isShowingDeleteError = false
				}
			} message: {
				Text(Constants.deleteTagErrorMessage)
			}
			
			Button {
				isShowingEditTagView = true
			} label: {
				Label("Edit", systemImage: "pencil")
			}
			.tint(.blue)
		}
		.popover(isPresented: $isShowingEditTagView) {
			EditTagView(tag: tag)
		}
	}
	
	private func delete(tag: Tag) {
		context.delete(tag)
		
		do {
			try context.save()
		} catch {
			isShowingDeleteError = true
		}
	}
}

