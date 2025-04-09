//
//  TaggedDestinationCellView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/9/25.
//

import SwiftUI

struct TaggedDestinationCellView: View {
	@Environment(\.modelContext) var context
	
	@State private var isShowingEditDestinationView: Bool = false
	@State private var isShowingAddTagView: Bool = false
	@State private var isShowingRemovalError: Bool = false
	@State private var isShowingDeleteError: Bool = false
	@State private var isShowingEditError: Bool = false
	
	var destination: Destination
	var tag: Tag
	
	var visitedToggleColor: Color {
		return destination.visited ? .red : .green
	}
	
	var visitedToggleLabel: String {
		return "Mark as \(destination.visited ? "Unvisited" : "Visited")"
	}

	var visitedToggleSymbol: String {
		return destination.visited ? "multiply.circle" : "checkmark.circle"
	}
	
	var body: some View {
		NavigationLink {
			DestinationDetailView(destination: destination)
		} label: {
			DestinationCellContentView(destination: destination)
		}
		.contextMenu {
			Button(action: toggleVisitedStatus) {
				Label(visitedToggleLabel, systemImage: visitedToggleSymbol)
			}
			
			Button {
				isShowingEditDestinationView = true
			} label: {
				Label("Edit", systemImage: "pencil")
			}
			
			Button {
				isShowingAddTagView = true
			} label: {
				Label("Add Tag to Destination", systemImage: "tag")
			}
			
			Button {
				removeTag()
			} label: {
				Label("Remove from Tag", systemImage: "multiply")
			}
			
			Button(role: .destructive) {
				delete(destination: destination)
			} label: {
				Label("Delete", systemImage: "trash")
			}
		}
		.swipeActions(edge: .leading, allowsFullSwipe: true) {
			Button {
				toggleVisitedStatus()
			} label: {
				Label(visitedToggleLabel, systemImage: visitedToggleSymbol)
			}
			.tint(visitedToggleColor)
			.alert(Constants.updateDestinationVisitedStatusErrorTitle, isPresented: $isShowingDeleteError) {
				Button("OK") {
					isShowingEditError = false
				}
			} message: {
				Text(Constants.updateDestinationVisitedStatusErrorMessage)
			}
		}
		.swipeActions(edge: .trailing, allowsFullSwipe: false) {
			Button {
				isShowingEditDestinationView = true
			} label: {
				Label("Edit", systemImage: "pencil")
			}
			.tint(.blue)
			
			Button(role: .destructive) {
				delete(destination: destination)
			} label: {
				Label("Delete", systemImage: "trash")
			}
			.alert(Constants.deleteDestinationErrorTitle, isPresented: $isShowingDeleteError) {
				Button("OK") {
					isShowingDeleteError = false
				}
			} message: {
				Text(Constants.deleteDestinationErrorMessage)
			}
		}
		.sheet(isPresented: $isShowingEditDestinationView) {
			EditDestinationView(destination: destination)
		}
		.popover(isPresented: $isShowingAddTagView) {
			TagDestinationView(destination: destination)
		}
		.alert(Constants.removeTagFromDestinationErrorTitle, isPresented: $isShowingRemovalError) {
			Button("OK") {
				isShowingRemovalError = false
			}
		} message: {
			Text(Constants.removeTagFromDestinationErrorMessage)
		}
	}
	
	private func toggleVisitedStatus() {
		destination.visited.toggle()
		do {
			try context.save()
		} catch {
			isShowingEditError = true
		}
	}
	
	private func removeTag() {
		destination.tags.removeAll { $0.tagId == tag.tagId }
		
		do {
			try context.save()
		} catch {
			isShowingRemovalError = true
		}
	}
	
	private func delete(destination: Destination) {
		context.delete(destination)
		
		do {
			try context.save()
		} catch {
			isShowingDeleteError = true
		}
	}
}

