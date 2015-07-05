//
//  EventManager.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation


class EventManager{
    var handlers:Array<HandlerCallback>
    
    init() {
        self.handlers = Array()
        
    }

    
    func addListener(target:AnyObject, evaluation:(event:Event)->Bool,callback:(event:Event)->Void) ->HandlerCallback{
        
        
        var handler:HandlerCallback = HandlerCallback(target: target,evaluation: evaluation, callback: callback)
        
        self.handlers.append(handler)
        return handler
        
    }

    // TODO: Must implement
    func removeListener(handler:HandlerCallback){
        

    }
    //TODO: Must implement
    func removeListener(target:AnyObject){
        
    }
        
    func triggerEvent(newEvent:Event){
        
        /// Reviso todos los handlers
        println("")
        println("Triggering event:");
        println(newEvent.description());
        println("")
        

        for handler:HandlerCallback in self.handlers{
            
            if let target: AnyObject = handler.target{
                if (handler.evaluation(event: newEvent)){
                    handler.callback(event: newEvent)
                }
            }
        }
    }
}
