//
//  AppDelegate.swift
//  HKProjekt-Desafio
//
//  Created by Gustavo De Sousa on 12/02/20.
//  Copyright © 2020 Gustavo De Sousa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor  = ColorPallete.COLOR_APP_TABBAR
        UITabBar.appearance().tintColor = ColorPallete.COLOR_APP_BLUE

        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = ColorPallete.COLOR_APP_BLUE
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
//        UIButton.appearance().tintColor = UIColor.white
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

