//
//  ViewController.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        
        var payloadText = Payload(senderIdentifier: "identifier", senderName: "Fabian", payloadData: PayloadData.PayloadDataText(text: "Custom text"))
        var eventText = Event(from: "x", to: "y", payload: payloadText)
        
        var payloadImageURL = Payload(senderIdentifier: "identifier", senderName: "Fabian", payloadData: PayloadData.PayloadDataImage(url: NSURL(string: "http://www.google.com")!))
        var eventImage = Event(from: "x", to: "y", payload: payloadImageURL)
        
        
        eventManager.triggerEvent(eventText)
        eventManager.triggerEvent(eventImage)

    }
    func addListeners(){
        
        eventManager.addListener({ (event:Event) -> Bool in
            
            return event.payload.senderName == "Fabian"
            
            }, callback: { (event:Event) -> Void in
                println("Fabian found listener A")
        });
        
        eventManager.addListener({ (event:Event) -> Bool in
            return event.payload.senderName == "Fabian"
            }, callback: { (event:Event) -> Void in
                println("Fabian found listener B")
        })
        
        
        eventManager.addListener({ (event:Event) -> Bool in
            return event.payload.senderName == "Ernesto"
            }, callback: { (event:Event) -> Void in
                println("Ernesto not found")
        })
        
        eventManager.addListener({ (event:Event) -> Bool in
            
            switch event.payload.data{
            case .PayloadDataText(let text):
                return (text == "Custom text");
            default: return false
            }
            
            }, callback: { (event:Event) -> Void in

                switch event.payload.data{
                case .PayloadDataText(let text):
                    
                    println("Playload data text \(text)")
                default:
                    println("Do nothing")
                }
                
        })
        
        
        eventManager.addListener({ (event:Event) -> Bool in
            //return true
    
            switch event.payload.data{
            case .PayloadDataImage(let url):
                return true;
                
            default:
                return false;
            }
            }, callback: { (event:Event) -> Void in
                switch event.payload.data{
                case .PayloadDataImage(let url):
                    println("image url \(url)")
                    
                default:
                    println("do nothing")
                }
        })
        
    }



}

