//
//  SocketViewController.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/5/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import UIKit


let socketManager = SocketManager(url: "http://localhost:30000")

class SocketViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        socketManager.connect()
        socketManager.addListener(SocketEvent.Message, target: self, evaluation: { (event:Event) -> Bool in
            return true
            }) { (event:Event) -> Void in
                println("shit happens")
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        socketManager.emit(SocketEvent.Message, payload: Payload(senderIdentifier: "me", senderName: "Fabian", payloadData: PayloadData.Text(text: "Como va?")))
        
    }

}
