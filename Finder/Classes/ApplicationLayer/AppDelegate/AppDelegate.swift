//
//  AppDelegate.swift
//  Finder
//
//  Created by Dmitrii on 18.03.17.
//  Copyright © 2017 klassneckii prod. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let assemblyActivator = AssemblyActivator()
    
    override init() {
        super.init()
        assemblyActivator.activateAssemblies()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

}

