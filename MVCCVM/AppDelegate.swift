//
//  AppDelegate.swift
//  MVCCVM
//
//  Created by Kacper Woźniak on 07/10/2017.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    let window: UIWindow! = UIWindow(frame: UIScreen.main.bounds)
    let coordinator = AppCoordinator()

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setGlobalNavigationBarAppearance()
        window.rootViewController = coordinator.viewController
        window.makeKeyAndVisible()
        return true
    }

    func setGlobalNavigationBarAppearance() {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .purple
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().tintColor = .white
    }

}
