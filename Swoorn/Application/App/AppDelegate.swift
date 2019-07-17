//
//  AppDelegate.swift
//  Swoorn
//
//  Created by Peter IJlst | The Mobile Company on 03/05/2019.
//  Copyright © 2019 Peter IJlst. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window?.makeKeyAndVisible()

        MyApp.shared.assembleDependencies([SharedAssembly(), AppAssembly()])
        MyApp.shared.process(.LAUNCH)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        MyApp.shared.saveState()
        MyApp.shared.process(.BACKGROUND)
    }
}
