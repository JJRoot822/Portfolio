//
//  EditTagView.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 4/7/25.
//

import SwiftUI

struct EditTagView: View {
	@Environment(\.modelContext) var context
	@Environment(\.dismiss) var dismiss
	
	@State private var tagData: TagFormData
	
	init(tag: Tag) {
		self._tagData = State(wrappedValue: TagFormData(tag: tag))
	}
	
	var body: some View {
		Form {
			TextField("Tag Title", text: $tagData.title)
			TagColorPicker(selection: $tagData.color)
			
			HStack {
				Button("Cancel", role: .cancel) {
					dismiss()
				}
				
				Button("Update Tag") {
					tagData.save(context: context)
				}
				.disabled(!TagValidator.isValidTag(title: tagData.title, color: tagData.color))
			}
			.onChange(of: tagData.shouldDismiss) {
				if tagData.shouldDismiss {
					dismiss()
				}
			}
			.alert(Constants.updateTagErrorTitle, isPresented: $tagData.isShowingSaveError) {
				Button("OK") {
					tagData.isShowingSaveError = false
				}
			} message: {
				Text(Constants.updateTagErrorMessage)
			}
		}
	}
}
