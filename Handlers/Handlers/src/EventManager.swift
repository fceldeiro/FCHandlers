//
//  EventManager.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation


class EventManager<T>{
  
  private let handlerMapTable  = NSMapTable(keyOptions: NSPointerFunctionsWeakMemory, valueOptions: NSPointerFunctionsStrongMemory)
  
  
  func addListener(owner:NSObject, evaluation:(event:T)->Bool,callback:(event:T)->Void) ->HandlerCallback<T>{
    
    //Callback may not be needed
    var handler = HandlerCallback<T>(evaluation: evaluation, callback: callback)
    
    
    //How many do i have before executing all
    if let handlers:NSMutableArray = self.handlerMapTable.objectForKey(owner) as? NSMutableArray {
      println("Handlers count before \(handlers.count)")
    }
    else{
      println("no handlers")
    }
    
    
    //new
    if  (self.handlerMapTable.objectForKey(owner) != nil){
      if let handlers:NSMutableArray = handlerMapTable.objectForKey(owner) as? NSMutableArray{
        
        handlers.addObject(handler)
      }
    }
    else{
      handlerMapTable.setObject(NSMutableArray(object: handler), forKey: owner)
    }
    
    //How many do i have after doing my logic
    if let handlers:NSMutableArray = handlerMapTable.objectForKey(owner) as? NSMutableArray {
      println("Handlers count after \(handlers.count)")
    }
    
    return handler
    
  }
  
  // TODO: Must implement
  func removeHandler(handler:HandlerCallback<T>){
    
    
    
  }
  //TODO: Must implement
  func removeListener(owner:NSObject){
    
    handlerMapTable.removeObjectForKey(owner)
    println(handlerMapTable)
    
  }
  
  func triggerEvent(newEvent:T){
    
    /// Reviso todos los handlers
    println("")
    println("Triggering event:");
    println(newEvent)
    println("")
    
    
    let allObjects:NSArray = handlerMapTable.keyEnumerator().allObjects
    
    
    /**
    *  PALOMITAS!!! ver como bajar esto
    */
    for key in allObjects{
      if let handlerArray:NSMutableArray = handlerMapTable.objectForKey(key) as? NSMutableArray{
        
        for  var index = 0 ; index < handlerArray.count ; ++index{
          
          if let handler:HandlerCallback<T> = handlerArray[index] as? HandlerCallback{
            if handler.evaluation(event: newEvent){
              handler.callback(event: newEvent)
            }
          }
        }
      }
    }
  }
}
