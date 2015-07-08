//
//  MenuTableViewController.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/5/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueMenuToSlack"{
            if let slackController : SlackChatTableViewController = segue.destinationViewController as? SlackChatTableViewController{
                slackController.targetUserIdentifier = "magoya"
            }
        }
    }
}
