//
//  AppDelegate.swift
//  MarvelHeroes
//
//  Created by Molnar Marton on 2022. 05. 14..
//

import UIKit
import UI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    let assemblyRegister = AssemblyRegister()
    var navigatorHelper: NavigatorHelper!
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        assemblyRegister.registerAssemblies()
        self.window = TouchInterceptorWindow()
        self.navigatorHelper = NavigatorHelper(window: self.window!)
        window?.makeKeyAndVisible()
        navigatorHelper.navigateToHeroesListScreen()
        
        return true
    }
}

