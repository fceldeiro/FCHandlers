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
    
    
    let socketEventListener  = SocketViewControllerSocketEventListener()
    
    deinit{
        println("deInit")
    }
    
    
    private func stopListening() {
        socketManager.removeListener(socketEventListener)
    }
    
    private func startListening() {
        
        weak var weakSelf  = self;
        
        socketManager.addListener(SocketEvent.Message, owner: socketEventListener, evaluation: { (event:Event) -> Bool in
            return event.payload?.senderName == "Fabian"
            }) { (event:Event) -> Void in
                
                if let payload:Payload = event.payload, let senderName:String = payload.senderName, let payloadData = payload.data{
                    
                    var message = String()
                    message += senderName
                    
                    switch payloadData{
                    case .Text(let text):
                        message+=" "
                        message+=text
                        weakSelf?.labelFabianLastMessage.text = senderName + " : " + message
                        
                    default: println("shit happens")
                    }
                }
                
                
        }
        
        socketManager.addListener(SocketEvent.Message, owner: socketEventListener, evaluation: { (event:Event) -> Bool in
            return event.payload?.senderName == "MisterX"
            }) { (event:Event) -> Void in
                
                if let payload:Payload = event.payload, let senderName:String = payload.senderName, let payloadData = payload.data{
                    
                    var message = String()
                    message += senderName
                    
                    switch payloadData{
                    case .Text(let text):
                        message+=" "
                        message+=text
                        weakSelf?.labelMisterXLastMessage.text = senderName + " : " + message
                        
                    default: println("shit happens")
                    }
                }
                
        }

    }
    override func viewWillDisappear(animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        socketManager.connect()
        startListening()
        
        

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
    
    @IBAction func buttonStartListeningPressed(sender:UIButton){
        startListening()
    }
    @IBAction func buttonStopListeningPressed(sender:UIButton){
        stopListening()
    }
    
    @IBAction func buttonClearPressed(sender:UIButton){
        labelFabianLastMessage.text = ""
        labelMisterXLastMessage.text = ""
    }

}
