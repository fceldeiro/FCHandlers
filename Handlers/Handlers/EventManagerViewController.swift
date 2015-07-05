//
//  EventManagerViewController
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import UIKit

class EventManagerViewController: UIViewController {

    var eventManager : EventManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.eventManager = EventManager()
        addListeners()
        launchCustomEvents()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func launchCustomEvents(){
        
        var payloadText = Payload(senderIdentifier: "xxx", senderName: "Fabian", payloadData: PayloadData.Text(text: "Custom text"))
        var eventText = Event(identifier:"xxx-text", from: "x", to: "y", payload: payloadText)
        
        var payloadImageURL = Payload(senderIdentifier: "xxx", senderName: "Fabian", payloadData: PayloadData.Image(url: NSURL(string: "http://www.google.com")!))
        var eventImage = Event(identifier:"xxx-image", from: "x", to: "y", payload: payloadImageURL)
        
        
        var payloadCustom = Payload(senderIdentifier: "xxx", senderName: "Fabian", payloadData: PayloadData.Custom(customPayload: CustomPayloadData()))
        var eventCustom = Event(identifier:"xxx-custom",from: "x", to: "y", payload: payloadCustom)
            
            
        eventManager.triggerEvent(eventText)
        eventManager.triggerEvent(eventImage)
        eventManager.triggerEvent(eventCustom)

    }
    func addListeners(){
        
        eventManager.addListener(self , evaluation: { (event:Event) -> Bool in
            
            return event.payload.senderName == "Fabian"
            
            }, callback: { (event:Event) -> Void in
                println("Event with payload.senderName Fabian arrived")
        });
        
        
        
        eventManager.addListener(self, evaluation: { (event:Event) -> Bool in
            return event.payload.senderName == "Ernesto"
            }, callback: { (event:Event) -> Void in
                println("Event with payload.senderName Ernesto arrived")
        })
        
        eventManager.addListener(self, evaluation: { (event:Event) -> Bool in
            
            switch event.payload.data{
            case .Text(let text):
                return (text == "Custom text");
            default: return false
            }
            
            }, callback: { (event:Event) -> Void in

                switch event.payload.data{
                case .Text(let text):
                    println("Event with data of type PayloadDataText with text Custom text = \(text) arrived")
                default:
                    println("Do nothing")
                }
                
        })
        
        
        eventManager.addListener(self, evaluation: { (event:Event) -> Bool in
            //return true
    
            switch event.payload.data{
            case .Image(let url):
                return true;
                
            default:
                return false;
            }
            }, callback: { (event:Event) -> Void in
                switch event.payload.data{
                case .Image(let url):
                    println("Event with data of type PayloadDataImage with imageURL \(url) arrived")
                    
                default:
                    println("do nothing")
                }
        })
        
    }

    deinit{
        self.eventManager .removeListener(self)
    }


}

