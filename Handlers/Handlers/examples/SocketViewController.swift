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
    
    
    socketManager.addListener(socketEventListener,
      socketEventType: SocketEventType.Message,
      evaluation: { (event:SocketEvent) -> Bool in
        
        return event.payload?.senderName() == "Fabian"
        
      },
      callback: { (event:SocketEvent) -> Void in
        
        if let payload:PayloadType = event.payload{
          
          var message : String = String()
          message += payload.senderName()!
          
          switch payload{
          case .Text(payload: let payloadText):
            message += " "
            message += payloadText!.text!
            weakSelf?.labelFabianLastMessage.text = message
          case .Image(let payloadImage):
            print("TODO")
          default:
            print("TODO")
          }
        }
    })
    
    
    socketManager.addListener(socketEventListener,
      socketEventType: SocketEventType.Message,
      evaluation: { (event:SocketEvent) -> Bool in
        
        return event.payload?.senderName() == "MisterX"
        
      },
      callback: { (event:SocketEvent) -> Void in
        
        if let payload:PayloadType = event.payload{
          
          var message : String = String()
          message += payload.senderName()!
          
          switch payload{
          case .Text(payload: let payloadText):
            message += " "
            message += payloadText!.text!
            weakSelf?.labelMisterXLastMessage.text = message
          case .Image(let payloadImage):
            print("TODO")
          default:
            print("TODO")
          }
        }
    })
    
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
    
    let payloadText:PayloadText = PayloadText(text: "Como va?")
    payloadText.senderName = "Fabian"
    payloadText.senderIdentifier = "fabi"
    
    socketManager.emit(socketEventType: SocketEventType.Message, payload: PayloadType.Text(payload: payloadText))
    //  socketManager.emit(SocketEvent.Message, payload: Payload(senderIdentifier: "fabi", senderName: "Fabian", payloadData: PayloadData.Text(text: "Como va?")))
    
  }
  @IBAction func buttonMessageFromXPressed(sender:UIButton){
    
    let payloadText:PayloadText = PayloadText(text: "GATO?")
    payloadText.senderName = "MisterX"
    payloadText.senderIdentifier = "mister_x"
    
    socketManager.emit(socketEventType: SocketEventType.Message, payload: PayloadType.Text(payload: payloadText))
    // socketManager.emit(SocketEvent.Message, payload: Payload(senderIdentifier: "mister_x", senderName: "MisterX", payloadData: PayloadData.Text(text: "GATO")))
    
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
