//
//  AppDelegate.swift
//  NumerologyApp
//
//  Created by Tetiana on 12.01.2021.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        window.overrideUserInterfaceStyle = .light
        FirebaseApp.configure()
        appCoordinator = AppCoordinator(window: window)
        appCoordinator?.start()
        
        return true
    }

}

