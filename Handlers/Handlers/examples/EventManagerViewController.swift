//
//  EventManagerViewController
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import UIKit

class EventManagerViewController: UIViewController {

    let eventManager  = EventManager<SocketEvent>()
    
    let socketEventListener  = SocketViewControllerSocketEventListener()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addListeners()
        launchCustomEvents()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func launchCustomEvents(){
        
        var payloadText = PayloadText(text: "textDemo")
        var eventText = SocketEvent(identifier: "xxx-test", from: "me", to: "she", payload: PayloadType.Text(payload: payloadText))
        
        var payloadImage = PayloadImage(imageURL: NSURL(string: "localhost:30000")!)
        var eventImage = SocketEvent(identifier: "xxx-test-image", from: "me", to: "she", payload: PayloadType.Image(payload: payloadImage))
        
        eventManager.triggerEvent(eventText)
        eventManager.triggerEvent(eventImage)
        
        /*
        var payloadText = Payload(senderIdentifier: "xxx", senderName: "Fabian", payloadData: PayloadData.Text(text: "Custom text"))
        var eventText = Event(identifier:"xxx-text", from: "x", to: "y", payload: payloadText)
        
        var payloadImageURL = Payload(senderIdentifier: "xxx", senderName: "Fabian", payloadData: PayloadData.Image(url: NSURL(string: "http://www.google.com")!))
        var eventImage = Event(identifier:"xxx-image", from: "x", to: "y", payload: payloadImageURL)
        
        
        var payloadCustom = Payload(senderIdentifier: "xxx", senderName: "Fabian", payloadData: PayloadData.Custom(customPayload: CustomPayloadData()))
        var eventCustom = Event(identifier:"xxx-custom",from: "x", to: "y", payload: payloadCustom)
            
            
        eventManager.triggerEvent(eventText)
        eventManager.triggerEvent(eventImage)
        eventManager.triggerEvent(eventCustom)
        */

    }
    func addListeners(){
        
        
        var array = Array<Int>()
        
        eventManager.addListener(self.socketEventListener , evaluation: { (event:SocketEvent) -> Bool in
            
            return event.from == "me"
            
            }, callback: { (event:SocketEvent) -> Void in
                println("Event from me arrived")
        });
        
        
        
        eventManager.addListener(self.socketEventListener, evaluation: { (event:SocketEvent) -> Bool in
            return event.from == "she"
            }, callback: { (event:SocketEvent) -> Void in
                println("Event from shearrived")
        })
        
        eventManager.addListener(self.socketEventListener, evaluation: { (event:SocketEvent) -> Bool in
            
            if let payloadType = event.payload {
                switch payloadType{
                case .Text(let payloadText):
                    if let text = payloadText?.text{
                        return (text as NSString).containsString("Demo")
                    }

                default:
                    return false
                }
            }
            
            return false
            
            
            }, callback: { (event:SocketEvent) -> Void in

                print("Event containing word Demo arrived")
                
        })
        
    }

    deinit{
        self.eventManager .removeListener(self)
    }


}

