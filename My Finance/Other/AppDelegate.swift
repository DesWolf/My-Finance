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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let schemaVersion: UInt64 = 12
        let config = Realm.Configuration( schemaVersion: schemaVersion, migrationBlock: { migration, oldSchemaVersion in
                    
            if (oldSchemaVersion < schemaVersion) {}
            })
            Realm.Configuration.defaultConfiguration = config
        
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore
               {
                    print("Not first launch.")
                self.window = UIWindow(frame: UIScreen.main.bounds)

                 let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                 let viewController = storyboard.instantiateViewController(withIdentifier: "StartVC") as! StartViewController

                 self.window?.rootViewController = viewController
                 self.window?.makeKeyAndVisible()      
               }
               else
               {
                   print("First launch")
               }


          
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
           
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


