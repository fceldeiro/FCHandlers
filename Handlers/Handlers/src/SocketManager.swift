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


enum SocketEventType: String{
    case Connect = "connect"
    case Message = "message"
    case Error = "error"
}

class SocketManager {
    
    private let socket:SocketIOClient
    private lazy var eventManagers  = Dictionary<SocketEventType,EventManager<SocketEvent>>()
    
    
    init(url:String){
        
        self.socket = SocketIOClient(socketURL: url)
        self.addHandlers()
        
    }
    
    private func addHandlers(){
        
        eventManagers[SocketEventType.Connect] = EventManager<SocketEvent>()
        socket.on(SocketEventType.Connect.rawValue) { data, ack in
            
           println("Socket connected")
            
        }
        
        eventManagers[SocketEventType.Message] = EventManager<SocketEvent>()
        socket.on(SocketEventType.Message.rawValue) { data, ack in
            
            
            if let eventDictionary: AnyObject = data!.lastObject{
                let json = JSON(eventDictionary)
                
                let event: SocketEvent = SocketEvent(json: json)
                if let eventManager = self.eventManagers[SocketEventType.Message]{
                    eventManager.triggerEvent(event)
                }
            }
        }
        
        eventManagers[SocketEventType.Error] = EventManager<SocketEvent>()
        socket.on(SocketEventType.Error.rawValue) { data, ack in
            
        }
    }
    
    func connect (){
        socket.connect()
    }
    func disconnect(){
        socket.close(fast: false)
    }
    
    func addListener(socketEventType:SocketEventType, owner:NSObject, evaluation:(event:SocketEvent)->Bool,callback:(event:SocketEvent)->Void) ->HandlerCallback<SocketEvent>?{
        
        if let manager:EventManager<SocketEvent> = self.eventManagers[socketEventType] {
            return  manager.addListener(owner,evaluation: evaluation,callback: callback)

        }
        else{
            return nil
        }
     
    }
    
    // TODO: Must implement
    func removeListener(handler:HandlerCallback<SocketEvent>){
        
    }
    
    func removeListener(target:NSObject){
        
        for socketEventType:SocketEventType  in self.eventManagers.keys{
            removeListener(socketEventType, target: target)
        }
    }
    
    func removeListener(socketEventType:SocketEventType , target:NSObject){
        
        if let eventManager = self.eventManagers[socketEventType]{
            eventManager.removeListener(target)
        }
        
    }
    
    func emit(socketEventType:SocketEventType, event:SocketEvent){
        socket.emit(socketEventType.rawValue, event.jsonDictionary())
    }
    func emit(socketEventType:SocketEventType, payload:PayloadType) -> SocketEvent{
        
        //let event = Event(identifier:"xxx-text", from: "x", to: "y", payload: payload)
        let event = SocketEvent(identifier: "xxx-test", from: "x", to: "y", payload: payload)
        socket.emit(socketEventType.rawValue, event.jsonDictionary())
        return event
        
    }
    


}