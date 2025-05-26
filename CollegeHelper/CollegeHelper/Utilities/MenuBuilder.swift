//
//  MenuBuilder.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/23/25.
//

import Cocoa

class MenuBuilder {
	static let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String ?? "CollegeHelper"
	
	static func buildMenuBar() -> NSMenu {
		let menuBar = NSMenu()
		let appItem = buildApplicationMenu()
		let fileItem = buildFileMenu()
		let editItem = buildEditMenu()
		let viewItem = buildViewMenu()
		let windowItem = buildWindowMenu()
		
		menuBar.addItem(appItem)
		menuBar.addItem(fileItem)
		menuBar.addItem(editItem)
		menuBar.addItem(viewItem)
		menuBar.addItem(windowItem)
		
		return menuBar
	}
	
	private static func buildApplicationMenu() -> NSMenuItem {
		let appMenu = NSMenu()
		let appMenuItem = NSMenuItem()
		
		let aboutItem = NSMenuItem(title: "About \(appName)", action: #selector(NSApplication.shared.orderFrontStandardAboutPanel(_:)), keyEquivalent: "")
		aboutItem.target = NSApplication.shared
		
		let firstSeparator = NSMenuItem.separator()
		
		let hideItem = NSMenuItem(title: "Hide", action: #selector(NSApplication.shared.hide), keyEquivalent: "h")
		hideItem.target = NSApplication.shared
		hideItem.keyEquivalentModifierMask = .command
		
		let hideOthersItem = NSMenuItem(title: "Hide Others", action: #selector(NSApplication.shared.hideOtherApplications), keyEquivalent: "h")
		hideOthersItem.target = NSApplication.shared
		hideOthersItem.keyEquivalentModifierMask = [ .command, .option ]
		
		let showAllItem = NSMenuItem(title: "Show All", action: #selector(NSApplication.shared.unhideAllApplications), keyEquivalent: "")
		showAllItem.target = NSApplication.shared
		
		let secondSeparator = NSMenuItem.separator()
		
		let quitItem = NSMenuItem(title: "Quit \(appName)", action: #selector(NSApplication.shared.terminate), keyEquivalent: "q")
		quitItem.target = NSApplication.shared
		quitItem.keyEquivalentModifierMask = .command
		
		appMenu.addItem(aboutItem)
		appMenu.addItem(firstSeparator)
		appMenu.addItem(hideItem)
		appMenu.addItem(hideOthersItem)
		appMenu.addItem(showAllItem)
		appMenu.addItem(secondSeparator)
		appMenu.addItem(quitItem)
		
		appMenuItem.submenu = appMenu
		
		return appMenuItem
	}
	
	private static func buildFileMenu() -> NSMenuItem {
		let fileItem = NSMenuItem(title: "File", action: nil, keyEquivalent: "")
		let fileMenu = NSMenu()
		
		let closeItem = NSMenuItem(title: "Close", action: #selector(NSWindow.performClose(_:)), keyEquivalent: "w")
		closeItem.keyEquivalentModifierMask = .command
		
		fileMenu.addItem(closeItem)
	
		fileItem.submenu = fileMenu
		
		return fileItem
	}
	
	private static func buildEditMenu() -> NSMenuItem {
		let editItem = NSMenuItem(title: "Edit", action: nil, keyEquivalent: "")
		let editMenu = NSMenu()
		
		let undoItem = NSMenuItem(title: "Undo", action: Selector(("undo:")), keyEquivalent: "z")
		undoItem.keyEquivalentModifierMask = .command
		
																	let redoItem = NSMenuItem(title: "Redo", action: Selector(("redo:")), keyEquivalent: "z")
		undoItem.keyEquivalentModifierMask = [ .command, .shift ]
																	
		let separator = NSMenuItem.separator()
		
		let cutItem = NSMenuItem(title: "Cut", action: #selector(NSText.cut(_:)), keyEquivalent: "x")
		cutItem.keyEquivalentModifierMask = .command
		
		let copyItem = NSMenuItem(title: "Copy", action: #selector(NSText.copy(_:)), keyEquivalent: "c")
		copyItem.keyEquivalentModifierMask = .command
		
		let pasteItem = NSMenuItem(title: "Paste", action: #selector(NSText.paste(_:)), keyEquivalent: "v")
		pasteItem.keyEquivalentModifierMask = .command
		
		let deleteItem = NSMenuItem(title: "Delete", action: #selector(NSText.delete(_:)), keyEquivalent: "")
		
		let selectAllItem = NSMenuItem(title: "Select All", action: #selector(NSText.selectAll(_:)), keyEquivalent: "a")
		selectAllItem.keyEquivalentModifierMask = .command
		
		editMenu.addItem(undoItem)
		editMenu.addItem(redoItem)
		editMenu.addItem(separator)
		editMenu.addItem(cutItem)
		editMenu.addItem(copyItem)
		editMenu.addItem(pasteItem)
		editMenu.addItem(deleteItem)
		editMenu.addItem(selectAllItem)
		
		editItem.submenu = editMenu
		
		return editItem
	}
	
	private static func buildViewMenu() -> NSMenuItem {
		let viewItem = NSMenuItem(title: "View", action: nil, keyEquivalent: "")
		let viewMenu = NSMenu()
		
		let enterFullScreenItem = NSMenuItem(title: "Enter Full Screen", action: #selector(NSWindow.toggleFullScreen(_:)), keyEquivalent: "f")
		enterFullScreenItem.keyEquivalentModifierMask = [ .command, .control ]
	
		viewMenu.addItem(enterFullScreenItem)
		
		viewItem.submenu = viewMenu
		
		return viewItem
	}
	
	private static func buildWindowMenu() -> NSMenuItem {
		let windowItem = NSMenuItem(title: "Window", action: nil, keyEquivalent: "")
		let windowMenu = NSMenu()

		let reopenItem = NSMenuItem(title: "Reopen", action: #selector(Constants.appDelegate.reopen), keyEquivalent: "0")
		reopenItem.keyEquivalentModifierMask = .command
		reopenItem.target = Constants.appDelegate
		
		let minimizeItem = NSMenuItem(title: "Minimize", action: #selector(NSWindow.performMiniaturize(_:)), keyEquivalent: "m")
		minimizeItem.keyEquivalentModifierMask = .command
		
		let zoomItem = NSMenuItem(title: "Zoom", action: #selector(NSWindow.performZoom(_:)), keyEquivalent: "")
		
		let bringAllToFrontItem = NSMenuItem(title: "Bring All to Front", action: #selector(NSApplication.shared.arrangeInFront(_:)), keyEquivalent: "")
		
		windowMenu.addItem(reopenItem)
		windowMenu.addItem(minimizeItem)
		windowMenu.addItem(zoomItem)
		windowMenu.addItem(bringAllToFrontItem)
		
		windowItem.submenu = windowMenu
		
		return windowItem
	}
}
