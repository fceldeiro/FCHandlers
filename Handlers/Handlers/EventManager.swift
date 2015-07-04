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

    
    func addListener(evaluation:(event:Event)->Bool,callback:()->Void){
        
        self.handlers.append(HandlerCallback(evaluation: evaluation, callback: callback))
        
    }
    
    func triggerEvent(newEvent:Event){
        
        /// Reviso todos los handlers
        println("triggering event")
        

        for handler:HandlerCallback in self.handlers{
            
            if (handler.evaluation(event: newEvent)){
                handler.callback()
            }
        }
    }
}