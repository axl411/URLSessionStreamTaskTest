//
//  AppDelegate.swift
//  StreamTest
//
//  Created by Gu Chao on 2018/11/16.
//  Copyright © 2018 linecorp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        StreamManager.shared.startConnection()

        return true
    }

}


