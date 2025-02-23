//
//  AppDelegate.swift
//  Nomad's Travel
//
//  Created by Joshua Root on 2/18/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let dataController = DataController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let tagsCount = try! dataController.container.viewContext.count(for: Tag.fetchRequest())

        if tagsCount == 0 {
            try! dataController.createTag(title: "All", color: "clear")
        }
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}
