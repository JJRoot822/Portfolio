//
//  TagDestinationView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/8/25.
//

import SwiftUI
import SwiftData

struct TagDestinationView: View {
	@Environment(\.modelContext) var context
	@Environment(\.dismiss) var dismiss
	
	var destination: Destination
	
	@Query(
		sort: [
			SortDescriptor(\Tag.title, order: .forward)
		]
	) var tags: [Tag]
	
	@State private var selectedTag: UUID = Constants.noTagId
	@State private var isShowingError: Bool = false
	
	var filteredTags: [Tag] {
		return tags.filter(destination.tags.contains)
	}
	
	var body: some View {
		Form {
			Picker("Tags", selection: $selectedTag) {
				Text("No Selection").tag(Constants.noTagId)
				
				ForEach(filteredTags, id: \.id) { tag in
					Text(tag.title).tag(tag.tagId)
				}
			}
			.disabled(selectedTag == Constants.noTagId && tags.isEmpty)
			
			HStack {
				Button("Cancel", role: .cancel) {
					dismiss()
				}
				
				Button("Add Tag to Destination") {
					addToDestination()
				}
				.alert(Constants.tagDestinationErrorTitle, isPresented: $isShowingError) {
					Button("OK") {
						isShowingError = false
					}
				} message: {
					Text(Constants.tagDestinationErrorMessage)
				}
			}
		}
	}
	
	private func addToDestination() {
		if selectedTag != Constants.noTagId {
			var fetchDescriptor = FetchDescriptor<Tag>()
			fetchDescriptor.fetchLimit = 1
			
			fetchDescriptor.predicate = #Predicate<Tag> { tag in
				return tag.tagId == selectedTag
			}
			
			do {
				let results = try context.fetch(fetchDescriptor)
				
				if let tag = results.first {
					destination.tags.append(tag)
					try context.save()
				}
			} catch {
				isShowingError = true
			}
		}
	}
}
