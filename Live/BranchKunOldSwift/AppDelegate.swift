//
//  AppDelegate.swift
//  BranchKunOldSwift
//
//  Created by Kun on 6/2/2023.
//

import UIKit
import BranchSDK
import AppTrackingTransparency
import AdSupport

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Branch.enableLogging()
        //SDK-2327
//        #if DEBUG
//            Branch.setUseTestBranchKey(true)
//        #endif
        
        
        //Branch.setTrackingDisabled(false)

        //For native Link.
        Branch.getInstance().checkPasteboardOnInstall()
            
            //enable logging

            
            //SDK validation
            //Branch.getInstance().validateSDKIntegration()
        
        //Branch.setUseTestBranchKey(true)
        
        
        Branch.getInstance().initSession(launchOptions: launchOptions) { (params, error) in
             // do stuff with deep link data (nav to page, display content, etc)
            //print(params as? [String: AnyObject] ?? {})
            

            // latest
            let sessionParams = Branch.getInstance().getLatestReferringParams()
            
            print("App delegate param")
            var stuff: [String: AnyObject] = (sessionParams as? [String: AnyObject]) ?? [:]

            
            
            // Convert the dictionary to JSON data
            if let jsonData = try? JSONSerialization.data(withJSONObject: stuff, options: .prettyPrinted) {
                // Convert JSON data to a string
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    // Create the alert controller with the JSON string as the message
                    let alertController = UIAlertController(title: "Deep Link data", message: jsonString, preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    
                    // Present the alert
                    if var topController = UIApplication.shared.keyWindow?.rootViewController {
                        while let presentedViewController = topController.presentedViewController {
                            topController = presentedViewController
                        }
                        topController.present(alertController, animated: true, completion: nil)
                    }
                }
            }
            
//            //getting deeplink path
//            if let sessionParams = sessionParams as? [String: AnyObject], let deepLinkPath = sessionParams["deeplink_path"] as? String {
//                // Use deepLinkPath here
//                print("Deep Link Path: \(deepLinkPath)")
//                
//                // Create and present an alert with the deep link path
//                let alertController = UIAlertController(title: "Deep Link Path", message: deepLinkPath, preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                
//                // Get the top-most view controller to present the alert
//                if var topController = UIApplication.shared.keyWindow?.rootViewController {
//                    while let presentedViewController = topController.presentedViewController {
//                        topController = presentedViewController
//                    }
//                    topController.present(alertController, animated: true, completion: nil)
//                }
//            
//                
//                
//            } else {
//                // Handle the case where the "deeplink_path" key is not present or its value is not a string
//                print("No deep link path found or invalid type")
//            }
            
            
            //Documentation x
            let installParams = Branch.getInstance().getLatestReferringParamsSynchronous()
            print("App delegate install param")
            print(installParams as? [String: AnyObject] ?? {})
            
        }
        
        return true
    }
    
    
    //Handler for the URI scheme
    //to test this out, we need to remove the associated domains
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        

        let urlString = url.absoluteString
        
        // Display the entire URL string in a popup or log it
        showURLStringPopup(urlString: urlString)
        
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
    
    func showURLStringPopup(urlString: String) {
        // Create an alert controller
        let alertController = UIAlertController(
            title: "URL String Detected",
            message: "The URL string is: \(urlString)",
            preferredStyle: .alert
        )
        
        // Add an action to the alert (e.g., OK button)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Get the root view controller to present the alert
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            // Present the alert
            rootViewController.present(alertController, animated: true, completion: nil)
        }
    }
}

