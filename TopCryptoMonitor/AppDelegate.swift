//
//  AppDelegate.swift
//  TopCryptoMonitor
//
//  Created by Alessandro Schioppetti on 21/12/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var cryptoCoordinator: CryptoCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        cryptoCoordinator = CryptoCoordinator()
        cryptoCoordinator?.start(from: window)
        
        return true
    }

}

