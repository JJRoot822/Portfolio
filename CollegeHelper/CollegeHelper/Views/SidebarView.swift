//
//  SidebarView.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/23/25.
//

import Cocoa

class SidebarView: NSView {
	var table: NSTableView!
	var column: NSTableColumn!
	
	init() {
		super.init(frame: .zero)
	
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("Not supported")
	}
	
	private func configure() {
		configureTable()
		configureConstraints()
	}
	
	private func configureTable() {
		table = NSTableView()
		table.style = .sourceList
		table.selectRowIndexes([ 0 ], byExtendingSelection: false)
		table.headerView = nil
		table.allowsEmptySelection = false
		table.allowsTypeSelect = false
		table.allowsMultipleSelection = false
		table.translatesAutoresizingMaskIntoConstraints = false
		
		column = NSTableColumn(identifier: Constants.sidebarColumnIdentifier)
		table.addTableColumn(column)
		
		addSubview(table)
	}
	
	private func configureConstraints() {
		NSLayoutConstraint.activate([
			table.topAnchor.constraint(equalTo: topAnchor),
			table.leadingAnchor.constraint(equalTo: leadingAnchor),
			table.bottomAnchor.constraint(equalTo: bottomAnchor),
			table.trailingAnchor.constraint(equalTo: trailingAnchor)
		])
	}
}
