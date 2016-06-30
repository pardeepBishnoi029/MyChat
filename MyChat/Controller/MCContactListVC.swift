//
//  MCContactListVC.swift
//  MyChat
//
//  Created by Pardeep Bishnoi on 15/06/16.
//  Copyright © 2016 Pardeep Bishnoi. All rights reserved.
//

import UIKit
import XMPPFramework

protocol ContactPickerDelegate{
    func didSelectContact(recipient: XMPPUserCoreDataStorageObject)
}

class MCContactListVC: UITableViewController,OneRosterDelegate {

    var delegate:ContactPickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OneRoster.sharedInstance.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if OneChat.sharedInstance.isConnected() {
            navigationItem.title = "Select a recipient"
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        OneRoster.sharedInstance.delegate = nil
    }
    
    func oneRosterContentChanged(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    // Mark: UITableView Datasources
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections: NSArray? =  OneRoster.buddyList.sections
        
        if section < sections!.count {
            let sectionInfo: AnyObject = sections![section]
            
            return sectionInfo.numberOfObjects
        }
        
        return 0;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return OneRoster.buddyList.sections!.count
    }
    
    // Mark: UITableView Delegates
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sections: NSArray? = OneRoster.sharedInstance.fetchedResultsController()!.sections
        
        if section < sections!.count {
            let sectionInfo: AnyObject = sections![section]
            let tmpSection: Int = Int(sectionInfo.name)!
            
            switch (tmpSection) {
            case 0 :
                return "Available"
                
            case 1 :
                return "Away"
                
            default :
                return "Offline"
                
            }
        }
        
        return ""
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("MCChatVC") as! MCChatVC
        viewController.recipient = OneRoster.userFromRosterAtIndexPath(indexPath: indexPath)
        self.navigationController?.pushViewController(viewController, animated: true)
        
        //_ = OneRoster.userFromRosterAtIndexPath(indexPath: indexPath)
        
        //delegate?.didSelectContact(OneRoster.userFromRosterAtIndexPath(indexPath: indexPath))
        //close(self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let user = OneRoster.userFromRosterAtIndexPath(indexPath: indexPath)
        
        cell!.textLabel!.text = user.displayName;
        cell!.detailTextLabel?.hidden = true
        
        if user.unreadMessages.intValue > 0 {
            cell!.backgroundColor = .orangeColor()
        } else {
            cell!.backgroundColor = .whiteColor()
        }
        
        OneChat.sharedInstance.configurePhotoForCell(cell!, user: user)
        
        return cell!;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
