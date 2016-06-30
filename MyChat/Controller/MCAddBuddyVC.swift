//
//  MCAddBuddyVC.swift
//  MyChat
//
//  Created by Pardeep Bishnoi on 30/06/16.
//  Copyright © 2016 Pardeep Bishnoi. All rights reserved.
//

import UIKit
import XMPPFramework

class MCAddBuddyVC: UIViewController {

    @IBOutlet weak var tfBuddyJabberId: UITextField!
    @IBOutlet weak var tfNickName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Class Methods
    
    //MARK : UIAction Methods
    @IBAction func btnAddBuddyTapped(sender: AnyObject) {
        let jabberXMPPJID = XMPPJID.jidWithString(tfBuddyJabberId.text)
        OneChat.sharedInstance.xmppRoster?.addUser(jabberXMPPJID, withNickname: tfNickName.text)
        OneChat.sharedInstance.xmppRoster?.subscribePresenceToUser(jabberXMPPJID)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("MCContactListVC") as! MCContactListVC
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func btnStartChatTapped(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("MCContactListVC") as! MCContactListVC
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
