//
//  AppDelegate.swift
//  iOS-Test-Blinqpay
//
//  Created by Mark Boleigha on 11/02/2022.
//  Copyright © 2022 Blinqpay. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        FirebaseApp.configure()
        let controller = HomeViewController()
//        controller.viewModel = StoriesViewModel()
        self.window?.rootViewController = controller.wrapInNavigation()
        self.window?.makeKeyAndVisible()
        return true
    }
}

