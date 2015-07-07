//
//  EventManager.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation


class EventManager{

    let handlerMapTable : NSMapTable;
    
    init() {
  
        self.handlerMapTable = NSMapTable(keyOptions: NSPointerFunctionsWeakMemory, valueOptions: NSPointerFunctionsStrongMemory)
    }

    
    func addListener(owner:NSObject, evaluation:(event:Event)->Bool,callback:(event:Event)->Void) ->HandlerCallback{
        
        //Callback may not be needed
        var handler:HandlerCallback = HandlerCallback(evaluation: evaluation, callback: callback)
        
        
        //How many do i have before executing all
        if let handlers:NSMutableArray = self.handlerMapTable.objectForKey(owner) as? NSMutableArray {
            println("Handlers count before \(handlers.count)")
        }
        else{
            println("no handlers")
        }

        
        //new
        if  (self.handlerMapTable.objectForKey(owner) != nil){
            if let handlers:NSMutableArray = self.handlerMapTable.objectForKey(owner) as? NSMutableArray{
                
                handlers.addObject(handler)
            }

            
        }
        else{
            self.handlerMapTable.setObject(NSMutableArray(object: handler), forKey: owner)
        }
        
        //How many do i have after doing my logic
        if let handlers:NSMutableArray = self.handlerMapTable.objectForKey(owner) as? NSMutableArray {
            println("Handlers count after \(handlers.count)")
        }
        
        return handler
        
    }

    // TODO: Must implement
    func removeListener(handler:HandlerCallback){
        

    }
    //TODO: Must implement
    func removeListener(owner:AnyObject){
        
        self.handlerMapTable.removeObjectForKey(owner)
        println(self.handlerMapTable)
        
    }
        
    func triggerEvent(newEvent:Event){
        
        /// Reviso todos los handlers
        println("")
        println("Triggering event:");
        println(newEvent.description());
        println("")
        
        
        let allObjects:NSArray = self.handlerMapTable.keyEnumerator().allObjects
        
        for key in allObjects{
            if let handlerArray:NSMutableArray = self.handlerMapTable.objectForKey(key) as? NSMutableArray{
            
                for  var index = 0 ; index < handlerArray.count ; ++index{
                    
                    if let handler:HandlerCallback = handlerArray[index] as? HandlerCallback{
                        if handler.evaluation(event: newEvent){
                            handler.callback(event: newEvent)
                        }
                    }
                }
            }
        }
    }
}
