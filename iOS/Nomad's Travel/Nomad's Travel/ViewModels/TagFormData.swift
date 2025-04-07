//
//  TagFormData.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/7/25.
//

import SwiftData

@Observable
class TagFormData {
	var title: String
	var color: String
	var isShowingSaveError: Bool
	var shouldDismiss: Bool
	
	var tag: Tag?
	
	init() {
		self.tag = nil
		
		self.isShowingSaveError = false
		self.shouldDismiss = false
		
		self.title = ""
		self.color = TagColors.blue.resourceName
	}
	
	init(tag: Tag) {
		self.tag = tag
		
		self.isShowingSaveError = false
		self.shouldDismiss = false
		
		self.title = tag.title
		self.color = tag.color
	}
	
	private func createTag(context: ModelContext) {
		let tag = Tag(title: title, color: color, destinations: [])
		context.insert(tag)
		
		do {
			try context.save()
			shouldDismiss = true
		} catch {
			isShowingSaveError = true
		}
	}
	
	private func updateTag(_ tag: Tag, context: ModelContext) {
		tag.title = title
		tag.color = color
		tag.lastModifiedAt = .now
		
		do {
			try context.save()
			shouldDismiss = true
		} catch {
			isShowingSaveError = true
		}
	}
	
	func save(context: ModelContext) {
		if let tag = tag {
			updateTag(tag, context: context)
		} else {
			print("Tag is nil")
			createTag(context: context)
		}
	}
}
