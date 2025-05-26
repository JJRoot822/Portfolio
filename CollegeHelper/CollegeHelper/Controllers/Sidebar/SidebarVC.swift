//
//  SidebarVC.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/22/25.
//

import Cocoa

class SidebarVC: NSViewController {
	var sidebarView: SidebarView!
	
	override func loadView() {
		super.loadView()
		
		sidebarView = SidebarView()
		self.view = sidebarView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		configure()
	}
	
	private func configure() {
		sidebarView.table.delegate = self
		sidebarView.table.dataSource = self
	}
}
