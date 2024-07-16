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
            if UIDevice.current.userInterfaceIdiom == .mac {
                ContentView()
                    .frame(width: 1440, height: 900)
            } else {
                ContentView()
            }
            
        }
        
    }
}
