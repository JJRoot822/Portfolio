//
//  AppDelegate.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/18/25.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
	let dataController = DataController()
	
	var windowController: NSWindowController?
	
	private func createMainWindow() {
		let rootVC = RootVC()
		
		let window = NSWindow(
			contentRect: NSRect(x: 0, y: 0, width: 1280, height: 800),
			styleMask: [ .titled, .closable, .miniaturizable, .resizable ],
			backing: .buffered,
			defer: false
		)
		
		
		windowController = NSWindowController(window: window)
		windowController?.contentViewController = rootVC
		
		window.title = "CollegeHelper"
		window.center()
		
		windowController?.showWindow(self)
	}
	
	private func configureMainMenuBar() {
		let mainMenu = MenuBuilder.buildMenuBar()
		NSApp.mainMenu = mainMenu
	}
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
		createMainWindow()
		configureMainMenuBar()
	}

	func applicationWillTerminate(_ aNotification: Notification) {
		
	}

	func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
		return true
	}

	func windowWillReturnUndoManager(window: NSWindow) -> UndoManager? {
		return dataController.container.viewContext.undoManager
	}

	func applicationShouldTerminate(_ sender: NSApplication) -> NSApplication.TerminateReply {
		let context = dataController.container.viewContext
	    
	    if !context.commitEditing() {
	        return .terminateCancel
	    }
	    
	    if !context.hasChanges {
	        return .terminateNow
	    }
	    
	    do {
	        try context.save()
	    } catch {
	        let nserror = error as NSError

	        let result = sender.presentError(nserror)
	        if (result) {
	            return .terminateCancel
	        }
	        
	        let question = NSLocalizedString("Could not save changes while quitting. Quit anyway?", comment: "Quit without saves error question message")
	        let info = NSLocalizedString("Quitting now will lose any changes you have made since the last successful save", comment: "Quit without saves error question info");
	        let quitButton = NSLocalizedString("Quit anyway", comment: "Quit anyway button title")
	        let cancelButton = NSLocalizedString("Cancel", comment: "Cancel button title")
	        let alert = NSAlert()
	        alert.messageText = question
	        alert.informativeText = info
	        alert.addButton(withTitle: quitButton)
	        alert.addButton(withTitle: cancelButton)
	        
	        let answer = alert.runModal()
	        if answer == .alertSecondButtonReturn {
	            return .terminateCancel
	        }
	    }
	    return .terminateNow
	}

	func applicationDidResignActive(_ notification: Notification) {
		dataController.save()
	}
	
	func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
			if !flag { // If there are no visible windows
				windowController?.showWindow(self)
				
				return false
			}
			return true
		}
	
	@objc func reopen(_ sender: Any?) {
		windowController?.showWindow(sender)
	}
}

