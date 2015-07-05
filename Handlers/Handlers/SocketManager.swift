//
//  SocketManager.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/5/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation
import Socket_IO_Client_Swift



enum SocketEvent: String{
    case Connect = "connect"
    case Message = "message"
    case Error = "error"
}

class SocketManager {
    
    private let socket:SocketIOClient
    private var eventManagers : Dictionary<SocketEvent,EventManager>
    
    init(url:String){
        
        self.socket = SocketIOClient(socketURL: url)
        self.eventManagers = Dictionary()
        self.addHandlers()
        
    }
    
    private func addHandlers(){
        
        eventManagers[SocketEvent.Connect] = EventManager()
        socket.on(SocketEvent.Connect.rawValue) { data, ack in
            
           println("Socket connected")
            
        }
        
        eventManagers[SocketEvent.Message] = EventManager()
        socket.on(SocketEvent.Message.rawValue) { data, ack in
            
            
            if let eventDictionary: AnyObject = data!.lastObject {
                if let payloadDic:AnyObject = eventDictionary["payload"]{
                    let payload:Payload = Payload(senderIdentifier: "xxx", senderName: payloadDic["senderName"]! as! String, payloadData: PayloadData.Text(text: "xxxx"));
                
                //let payloadText:Payload = Payload( "xxx", senderName: eventDictionary["senderIdentifier"]!, payloadData: PayloadData.Text(text: "saarasa"));

                    let eventText = Event(identifier:"xxx-text", from: "x", to: "y", payload: payload)

                
                    let eventManager = self.eventManagers[SocketEvent.Message]
                    eventManager?.triggerEvent(eventText)
                }
                
            }
        
            /*
            let payloadText = Payload(senderIdentifier: "xxx", senderName: "Fabian", payloadData: PayloadData.Text(text: "Custom text"))
            let eventText = Event(identifier:"xxx-text", from: "x", to: "y", payload: payloadText)

            let eventManager = self.eventManagers[SocketEvent.Message]
            eventManager?.triggerEvent(eventText)
            */
            
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
    
    func addListener(socketEvent:SocketEvent, target:AnyObject, evaluation:(event:Event)->Bool,callback:(event:Event)->Void) ->HandlerCallback? {
        
        if let manager = self.eventManagers[socketEvent] {
            return  manager.addListener(target,evaluation: evaluation,callback: callback)

        }
        else{
            return nil
        }
     
    }
    
    // TODO: Must implement
    func removeListener(handler:HandlerCallback){
        
        
    }
    //TODO: Must implement
    func removeListener(target:AnyObject){
        
    }
    
    func emit(socketEvent:SocketEvent, payload:Payload){
        var dictionary:Dictionary<String,AnyObject> = Dictionary<String,AnyObject>()
        
        
        let payloadText = Payload(senderIdentifier: "xxx", senderName: "Fabian", payloadData: PayloadData.Text(text: "Custom text"))
        let eventText = Event(identifier:"xxx-text", from: "x", to: "y", payload: payloadText)
        
        dictionary["payload"] = ["senderName" : payload.senderName]
        
        socket.emit(socketEvent.rawValue, dictionary)
    }
    


}