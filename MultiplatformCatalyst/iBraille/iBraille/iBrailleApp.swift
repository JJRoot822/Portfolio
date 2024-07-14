//
//  iBrailleApp.swift
//  iBraille
//
//  Created by Joshua Root on 7/10/24.
//

import SwiftUI

@main
struct iBrailleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        
    }
}
