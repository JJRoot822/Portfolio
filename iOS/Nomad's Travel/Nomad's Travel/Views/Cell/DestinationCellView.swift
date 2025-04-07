//
//  DestinationCellView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 3/26/25.
//

import SwiftUI

struct DestinationCellView: View {
	@Environment(\.modelContext) var context
	
	@State private var isShowingEditDestinationView: Bool = false
	@State private var isShowingDeleteError: Bool = false
	@State private var isShowingEditError: Bool = false
	
	var destination: Destination
	
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
	}
	
	private func toggleVisitedStatus() {
		destination.visited.toggle()
		do {
			try context.save()
		} catch {
			isShowingEditError = true
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
