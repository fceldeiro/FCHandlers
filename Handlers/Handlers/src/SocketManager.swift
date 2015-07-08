//
//  SocketManager.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/5/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation
import Socket_IO_Client_Swift
import SwiftyJSON


enum SocketEvent: String{
    case Connect = "connect"
    case Message = "message"
    case Error = "error"
}

class SocketManager {
    
    private let socket:SocketIOClient
    private lazy var eventManagers : Dictionary<SocketEvent,EventManager> = Dictionary()
    
    init(url:String){
        
        self.socket = SocketIOClient(socketURL: url)
        self.addHandlers()
        
    }
    
    private func addHandlers(){
        
        eventManagers[SocketEvent.Connect] = EventManager()
        socket.on(SocketEvent.Connect.rawValue) { data, ack in
            
           println("Socket connected")
            
        }
        
        eventManagers[SocketEvent.Message] = EventManager()
        socket.on(SocketEvent.Message.rawValue) { data, ack in
            
            
            if let eventDictionary: AnyObject = data!.lastObject{
                let json = JSON(eventDictionary)
                
                let event: Event = Event(json: json)
                if let eventManager = self.eventManagers[SocketEvent.Message]{
                    eventManager.triggerEvent(event)
                }
            }
        }
        
        eventManagers[SocketEvent.Error] = EventManager()
        socket.on(SocketEvent.Error.rawValue) { data, ack in
            
        }
    }
    
    func connect (){
        socket.connect()
    }
    func disconnect(){
        socket.close(fast: false)
    }
    
    func addListener(socketEvent:SocketEvent, owner:NSObject, evaluation:(event:Event)->Bool,callback:(event:Event)->Void) ->HandlerCallback?{
        
        if let manager = self.eventManagers[socketEvent] {
            return  manager.addListener(owner,evaluation: evaluation,callback: callback)

        }
        else{
            return nil
        }
     
    }
    
    // TODO: Must implement
    func removeListener(handler:HandlerCallback){
        
    }
    
    func removeListener(target:AnyObject){
        
        for socketEvent:SocketEvent  in self.eventManagers.keys{
            self.eventManagers[socketEvent]?.removeListener(target)
        }
    }
    
    func removeListener(socketEvent:SocketEvent , target:AnyObject){
        
        if let eventManager = self.eventManagers[socketEvent]{
            eventManager.removeListener(target)
        }
        
    }
    
    func emit(socketEvent:SocketEvent, event:Event){
        socket.emit(socketEvent.rawValue, event.jsonDictionary())
    }
    func emit(socketEvent:SocketEvent, payload:PayloadType){
        
        //let event = Event(identifier:"xxx-text", from: "x", to: "y", payload: payload)
        let event = Event(identifier: "xxx-test", from: "x", to: "y", payload: payload)
        socket.emit(socketEvent.rawValue, event.jsonDictionary())
        
    }
    


}