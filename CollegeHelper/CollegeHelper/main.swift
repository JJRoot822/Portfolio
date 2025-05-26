//
//  main.swift
//  CollegeHelper
//
//  Created by Joshua Root on 5/23/25.
//

import Cocoa

let app = NSApplication.shared
let delegate = AppDelegate()

app.delegate = delegate

_ = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
