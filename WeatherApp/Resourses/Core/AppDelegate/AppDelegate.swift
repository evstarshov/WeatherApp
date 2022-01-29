//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Евгений Старшов on 29.01.2022.
//

import UIKit

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appStartManager: AppStartManager?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.appStartManager = AppStartManager(window: self.window)
        self.appStartManager?.start()
        return true
    }
}
