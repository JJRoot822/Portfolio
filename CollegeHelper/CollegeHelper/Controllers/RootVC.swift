//
//  RootVC.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/18/25.
//

import Cocoa

class RootVC: NSSplitViewController {
	var sidebarVC = SidebarVC()
	var dashboardVC = DashboardVC()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let sidebarItem = NSSplitViewItem(sidebarWithViewController: sidebarVC)
		let detailItem = NSSplitViewItem(viewController: dashboardVC)
		
		addSplitViewItem(sidebarItem)
		addSplitViewItem(detailItem)
	}
}
