//
//  ViewController.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var eventManager:EventManager = EventManager()
        
        eventManager.addListener({ (event:Event) -> Bool in
            
            return event.payload.senderName == "Fabian"
            
            }, callback: { () -> Void in
                println("Fabian found listener A")
        });
        
        eventManager.addListener({ (event:Event) -> Bool in
            return event.payload.senderName == "Fabian"
            }, callback: { () -> Void in
                println("Fabian found listener B")
        })
        
        
        eventManager.addListener({ (event:Event) -> Bool in
            return event.payload.senderName == "Ernesto"
            }, callback: { () -> Void in
                println("Ernesto not found")
        })
        
        
        
        var eventArrived = Event(from: "x", to: "y", payload: Payload(senderIdentifier: "identifier", senderName: "Fabian", data: "Data"))
        
        eventManager.triggerEvent(eventArrived)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

