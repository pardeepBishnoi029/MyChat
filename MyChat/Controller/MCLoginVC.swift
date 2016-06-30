//
//  MCLoginVC.swift
//  MyChat
//
//  Created by Pardeep Bishnoi on 15/06/16.
//  Copyright © 2016 Pardeep Bishnoi. All rights reserved.
//

import UIKit
import XMPPFramework
import Foundation

class MCLoginVC: UIViewController,XMPPRoomDelegate {

    @IBOutlet weak var tfJid: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnAddBuddy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAddBuddy.hidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLoginTapped(sender: AnyObject) {
        if OneChat.sharedInstance.isConnected() {
           
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewControllerWithIdentifier("MCAddBuddyVC") as! MCAddBuddyVC
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            SwiftLoader.show(animated: true)
            OneChat.sharedInstance.connect(username:tfJid.text!, password: tfPassword.text!) { (stream, error) -> Void in
                SwiftLoader.hide() 
                if let _ = error {
                    let alertController = UIAlertController(title: "Sorry", message: "An error occured: \(error)", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
                        //do something
                    }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                } else {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let viewController = storyboard.instantiateViewControllerWithIdentifier("MCAddBuddyVC") as! MCAddBuddyVC
                    self.navigationController?.pushViewController(viewController, animated: true)
                    self.btnAddBuddy.hidden = false
                    self.tfPassword.hidden = true
                }
            }
        }
    }
  
    @IBAction func btnAddBuddyTapped(sender: AnyObject) {
       
    }
}
