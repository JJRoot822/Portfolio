//
//  MacAppDelegate.swift
//  BookBucket
//
//  Created by Joshua Root on 4/5/24.
//

import Cocoa

class MacAppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        NSApplication.shared.mainMenu?.removeItem(at: 5)
        NSApplication.shared.mainMenu?.removeItem(at: 3)
    }
}
