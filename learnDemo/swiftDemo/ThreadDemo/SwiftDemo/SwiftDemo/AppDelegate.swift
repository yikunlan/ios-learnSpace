//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by  huangyikun on 2020/5/13.
//  Copyright © 2020  huangyikun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainVC = MainCV()
        let rootCtl = UINavigationController(rootViewController : mainVC)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootCtl
        window?.makeKeyAndVisible()
        
        //添加3D touch
//        let shortCutItemArr = NSArray.init()
        var shortCutItemArr: [UIApplicationShortcutItem] = []
        let icon = UIApplicationShortcutIcon.init(type: UIApplicationShortcutIcon.IconType.search)
        let shortItem = UIApplicationShortcutItem.init(type: "com.demo.serach", localizedTitle: "第一级", localizedSubtitle: "第二集", icon: icon, userInfo: nil)
        shortCutItemArr.append(shortItem)
        application.shortcutItems = shortCutItemArr
        
        return true
    }
}

