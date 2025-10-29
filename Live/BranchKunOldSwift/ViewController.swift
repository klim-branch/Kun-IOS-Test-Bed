//
//  ViewController.swift
//  BranchKunOldSwift
//
//  Created by Kun on 6/2/2023.
//
import UIKit
import BranchSDK
import AppTrackingTransparency
import AdSupport


class ViewController: UIViewController {
    
    @IBOutlet weak var HelloViewControl: UILabel!
    @IBOutlet weak var Hello: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        
//        let sessionParams = Branch.getInstance().getLatestReferringParams()
//        Branch.getInstance().setIdentity("Kun")

//        print("Session param testing")
//        print(sessionParams as? [String: AnyObject] ?? {})
//        Hello.text = sessionParams?["+is_first_session"] as? String
//        Hello.text = "branch testing"
    
    }
    
    @IBAction func MakePurchaseEvent(_ sender: Any) {
        
        print("Purchase Button clicked")
        
        // Create a BranchUniversalObject with your content data:
        let branchUniversalObject = BranchUniversalObject.init()

        // ...add data to the branchUniversalObject as needed...
        branchUniversalObject.canonicalIdentifier = "item/12345"
        branchUniversalObject.canonicalUrl        = "https://branch.io/item/12345"
        branchUniversalObject.title               = "My Item Title"

        branchUniversalObject.contentMetadata.contentSchema     = .commerceProduct
        branchUniversalObject.contentMetadata.quantity          = 1
        branchUniversalObject.contentMetadata.price             = 23.20
        branchUniversalObject.contentMetadata.currency          = .USD
        branchUniversalObject.contentMetadata.sku               = "1994320302"
        branchUniversalObject.contentMetadata.productName       = "my_product_name1"
        branchUniversalObject.contentMetadata.productBrand      = "my_prod_Brand1"
        branchUniversalObject.contentMetadata.productCategory   = .apparel
        branchUniversalObject.contentMetadata.productVariant    = "XL"
        branchUniversalObject.contentMetadata.condition         = .new
        branchUniversalObject.contentMetadata.customMetadata = [
                    "custom_key1": "custom_value1",
                    "custom_key2": "custom_value2"
                ]

        // Create a BranchEvent:
        let event = BranchEvent.standardEvent(.purchase)

        // Add the BranchUniversalObject with the content (do not add an empty branchUniversalObject):
        event.contentItems     = [ branchUniversalObject ]

        // Add relevant event data:
        event.alias            = "my custom alias"
        event.transactionID    = "12344555"
        event.currency         = .USD
        event.revenue          = 1.5
        event.shipping         = 10.2
        event.tax              = 12.3
        event.coupon           = "test_coupon"
        event.affiliation      = "test_affiliation"
        event.eventDescription = "Event_description"
        event.searchQuery      = "item 123"
        event.customData       = [
            "Custom_Event_Property_Key1": "Custom_Event_Property_val1",
            "Custom_Event_Property_Key2": "Custom_Event_Property_val2"
        ]
        event.logEvent() // Log the event.
        
        showPurchasePopup();
    }

    func showPurchasePopup() {
        // Create an alert controller
        let alertController = UIAlertController(
            title: "Purchase Confirmed",
            message: "You just bought some random item",
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
    
    @IBAction func GenerateLinkButton(_ sender: Any){
        
        let buo: BranchUniversalObject = BranchUniversalObject(canonicalIdentifier: "item/12345")
        let lp: BranchLinkProperties = BranchLinkProperties()

        buo.getShortUrl(with: lp) { url, error in
            print(url ?? "")
        }
        
        print("Clicked Generate Link")
    }
}
