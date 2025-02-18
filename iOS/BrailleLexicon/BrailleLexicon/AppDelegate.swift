//
//  AppDelegate.swift
//  iBraille
//
//  Created by Joshua Root on 7/12/24.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    override func buildMenu(with builder: any UIMenuBuilder) {
        builder.remove(menu: .format)
        builder.remove(menu: .help)
        builder.remove(menu: .services)
        builder.remove(menu: .font)
        builder.remove(menu: .text)
        builder.remove(menu: .toolbar)
        builder.remove(menu: .newScene)
    }
}
