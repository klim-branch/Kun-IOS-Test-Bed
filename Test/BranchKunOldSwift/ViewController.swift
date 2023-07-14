//
//  ViewController.swift
//  BranchKunOldSwift
//
//  Created by Kun on 6/2/2023.
//

import UIKit
import Branch

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func DisableTracking(sender: UIButton){
        
        let alertController = UIAlertController(title: "Welcome to the app", message: "Hello world", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                present(alertController, animated: true, completion: nil)
        
    }
    
    

    @IBAction func DisableTracking(_ sender: UISwitch) {
        
        let defaults = UserDefaults.standard
        let token = defaults.bool(forKey: "TrackingStatus")
        
        if token == false {
            sender.isEnabled = false
            print("Tracking enabled")
        }
        
        else{
            sender.isEnabled = true
            print("Tracking disabled")
        }
        
        print(String(token))
    
        let default2 = UserDefaults.standard
        default2.set(false, forKey: "TrackingStatus")
    }
}




