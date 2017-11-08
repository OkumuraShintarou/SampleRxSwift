//
//  AppDelegate.swift
//  RxSwiftSample
//
//  Created by 奥村晋太郎 on 2017/11/07.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureWindow()
        return true
    }
}

extension AppDelegate {
    // RootViewControllerを指定
    func configureWindow() {
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = UINavigationController(rootViewController: TextFieldViewController.vc())
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}

