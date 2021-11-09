//
//  AppDelegate.swift
//  YSCalendar
//
//  Created by xj on 2021/11/9.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = YSCalendarViewController()
        window?.makeKeyAndVisible()
    
        return true
    }
}

