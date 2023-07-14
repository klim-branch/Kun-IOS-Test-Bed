//
//  AppDelegate.swift
//  BranchKunOldSwift
//
//  Created by Kun on 6/2/2023.
//

import UIKit
import Branch

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        Branch.setUseTestBranchKey(true)
        
        let defaults = UserDefaults.standard
        let defaultValue = [ true: "trackingStatus"]
        
        let token = defaults.bool(forKey: "trackingStatus")
        
        Branch.getInstance().enableLogging()
        Branch.setTrackingDisabled(token)
        print("trackingStatus" + String(token))
        
        Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
             // do stuff with deep link data (nav to page, display content, etc)
            print(params as? [String: AnyObject] ?? {})
        }
        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        Branch.getInstance().application(app, open: url, options: options)
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
      // handler for Universal Links
        Branch.getInstance().continue(userActivity)
        return true
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // handler for Push Notifications
      Branch.getInstance().handlePushNotification(userInfo)
    }

}

