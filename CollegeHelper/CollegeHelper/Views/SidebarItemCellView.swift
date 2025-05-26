//
//  SidebarItemCellView.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/22/25.
//

import Cocoa

class SidebarItemCellView: NSTableCellView {
	static let reuseIdentifier: NSUserInterfaceItemIdentifier = .init("sidebar_item")
	
	private var sidebarItemImageView: NSImageView!
	private var titleView: NSTextField!
	
	func configure(title: String, image: NSImage) {
		configureImageView(image: image)
		configureTitleView(title: title)
		configureConstraints()
		
	}
	
	private func configureImageView(image: NSImage) {
		sidebarItemImageView = NSImageView(image: image)
		sidebarItemImageView.translatesAutoresizingMaskIntoConstraints = false
		sidebarItemImageView.imageScaling = .scaleProportionallyUpOrDown
		
		self.imageView = sidebarItemImageView
		self.imageView?.setAccessibilityElement(false)
		
		addSubview(sidebarItemImageView)
	}
	
	private func configureTitleView(title: String) {
		titleView = NSTextField()
		titleView.stringValue = title.isEmpty ? "---" : title
		titleView.textColor = title.isEmpty ? .secondaryLabelColor : .labelColor
		titleView.isEditable = false
		titleView.drawsBackground = false
		titleView.isSelectable = false
		titleView.isBezeled = false
		titleView.isBordered = false
		titleView.font = .preferredFont(forTextStyle: .body)
		titleView.translatesAutoresizingMaskIntoConstraints = false
		
		self.textField = titleView
		self.textField?.setAccessibilityElement(false)
		
		addSubview(titleView)
	}
	
	private func configureConstraints() {
		NSLayoutConstraint.activate([
			sidebarItemImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
			sidebarItemImageView.widthAnchor.constraint(equalToConstant: 20),
			sidebarItemImageView.heightAnchor.constraint(equalToConstant: 20),
			sidebarItemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
			
			titleView.leadingAnchor.constraint(equalTo: sidebarItemImageView.trailingAnchor, constant: 5),
			titleView.topAnchor.constraint(equalTo: topAnchor),
			titleView.bottomAnchor.constraint(equalTo: bottomAnchor),
			titleView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
	
	override func isAccessibilityElement() -> Bool {
		return true
	}
	
	override func accessibilityLabel() -> String? {
		return titleView.stringValue
	}
	
	override func accessibilityChildren() -> [Any]? {
		return []
	}
}
