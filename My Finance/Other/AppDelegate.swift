//
//  AppDelegate.swift
//  My Finance
//
//  Created by Максим Окунеев on 12/15/19.
//  Copyright © 2019 Максим Окунеев. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let schemaVersion: UInt64 = 12
        let config = Realm.Configuration( schemaVersion: schemaVersion, migrationBlock: { _, oldSchemaVersion in

        if oldSchemaVersion < schemaVersion {}
            })
        Realm.Configuration.defaultConfiguration = config

        if !UserDefaults.standard.bool(forKey: "didSee") {

            UserDefaults.standard.set(true, forKey: "didSee")
            print("First launch")

            self.window = UIWindow(frame: UIScreen.main.bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initialViewController = storyboard.instantiateViewController(withIdentifier: "PageViewController")
            self.window?.rootViewController = initialViewController
            self.window?.makeKeyAndVisible()
        } else {
            print("Not First launch")
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (_, _) in
            }
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

        func applicationWillResignActive(_ application: UIApplication) {
        }

        func applicationDidEnterBackground(_ application: UIApplication) {
        }

        func applicationWillEnterForeground(_ application: UIApplication) {
        }

        func applicationDidBecomeActive(_ application: UIApplication) {
        }

        func applicationWillTerminate(_ application: UIApplication) {
        }

    }
