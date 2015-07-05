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

    @IBOutlet weak var labelFabianLastMessage: UILabel!
    @IBOutlet weak var labelMisterXLastMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socketManager.connect()
        socketManager.addListener(SocketEvent.Message, target: self, evaluation: { (event:Event) -> Bool in
            return event.payload.senderName == "Fabian"
            }) { (event:Event) -> Void in
                
                var message = String()
                message += event.payload.senderName
                
                switch event.payload.data{
                case .Text(let text):
                    message+=" "
                    message+=text
                    self.labelFabianLastMessage.text = event.payload.senderName + " : " + message
                    
                default: println("shit happens")
                }

                
        }
        
        socketManager.addListener(SocketEvent.Message, target: self, evaluation: { (event:Event) -> Bool in
            return event.payload.senderName == "MisterX"
            }) { (event:Event) -> Void in
                
                var message = String()
                message += event.payload.senderName
                
                switch event.payload.data{
                case .Text(let text):
                    message+=" "
                    message+=text
                    self.labelMisterXLastMessage.text = event.payload.senderName + " : " + message
                    
                default: println("shit happens")
                }
                
                
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonMessageFromFabianPressed(sender: UIButton) {
        socketManager.emit(SocketEvent.Message, payload: Payload(senderIdentifier: "fabi", senderName: "Fabian", payloadData: PayloadData.Text(text: "Como va?")))
        
    }
    @IBAction func buttonMessageFromXPressed(sender:UIButton){
        socketManager.emit(SocketEvent.Message, payload: Payload(senderIdentifier: "mister_x", senderName: "MisterX", payloadData: PayloadData.Text(text: "GATO")))
        
    }

}
