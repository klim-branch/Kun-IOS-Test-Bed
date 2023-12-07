//
//  AppDelegate.swift
//  BranchKunOldSwift
//
//  Created by Kun on 6/2/2023.
//

import UIKit
import Branch
import AppTrackingTransparency
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        //For native Link.
        Branch.getInstance().checkPasteboardOnInstall()
        
        //enable logging
        Branch.getInstance().enableLogging()
        
        //SDK validation
        //Branch.getInstance().validateSDKIntegration()
        
        
        
        Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
             // do stuff with deep link data (nav to page, display content, etc)
            //print(params as? [String: AnyObject] ?? {})
            

            // latest
            let sessionParams = Branch.getInstance().getLatestReferringParams()
            print("App delegate param")
            print(sessionParams as? [String: AnyObject] ?? {})
            
            //Documentation x
            let installParams = Branch.getInstance().getLatestReferringParamsSynchronous()
            print("App delegate install param")
            print(installParams as? [String: AnyObject] ?? {})
            
            
            
        }
        
        return true
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        Branch.getInstance().application(app, open: url, options: options)
        print("get instance 1")
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
      // handler for Universal Links
        print("get instance 2")
        Branch.getInstance().continue(userActivity)
        return true
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      // handler for Push Notifications
      Branch.getInstance().handlePushNotification(userInfo)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        requestPermission()
        
    }
    
    //NEWLY ADDED PERMISSIONS FOR iOS 14
    func requestPermission() {
        ATTrackingManager.requestTrackingAuthorization { (status) in
            switch status {
            case .authorized:
                print("authorized")
                print(ASIdentifierManager.shared().advertisingIdentifier.uuidString) // IDFA
            case .denied:
                print("denied")
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            }
        }
    }
}

