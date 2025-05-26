//
//  SidebarVC+TableViewDelegate.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/22/25.
//

import Cocoa

extension SidebarVC: NSTableViewDelegate, NSTableViewDataSource {
	func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
		return 30
	}
	
	func numberOfRows(in tableView: NSTableView) -> Int {
		return Constants.sidebarItems.count
	}
	
	func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
		let cell: NSView?
		
		if let cellView = tableView.makeView(withIdentifier: SidebarItemCellView.reuseIdentifier, owner: nil) as? SidebarItemCellView {
			cell = cellView
		} else {
			let cellView = SidebarItemCellView()
			cellView.configure(
				title: Constants.sidebarItems[row].title,
				image: NSImage(systemSymbolName: Constants.sidebarItems[row].image, accessibilityDescription: nil)!
			)
			
			cell = cellView
		}
		
		return cell
	
		
	}
	
	func tableViewSelectionDidChange(_ notification: Notification) {
		
	}
}
