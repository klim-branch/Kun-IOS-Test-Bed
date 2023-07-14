//
//  ViewController.swift
//  BranchKunOldSwift
//
//  Created by Kun on 6/2/2023.
//
import UIKit
import Branch
import AppTrackingTransparency
import AdSupport


class ViewController: UIViewController {
    
    @IBOutlet weak var HelloViewControl: UILabel!
    @IBOutlet weak var Hello: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        
        let sessionParams = Branch.getInstance().getLatestReferringParams()

        print("Session param testing")
        print(sessionParams as? [String: AnyObject] ?? {})
        Hello.text = sessionParams?["+is_first_session"] as? String
        Hello.text = "branch testing"
    }
}

