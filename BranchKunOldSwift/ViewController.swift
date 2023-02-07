//
//  ViewController.swift
//  BranchKunOldSwift
//
//  Created by Kun on 6/2/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func showMessage(sender: UIButton){
        
        let alertController = UIAlertController(title: "Welcome to the app", message: "Hello world", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                present(alertController, animated: true, completion: nil)
        
    }


}

