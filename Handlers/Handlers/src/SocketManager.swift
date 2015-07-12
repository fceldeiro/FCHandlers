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

class SocketManager : NSObject {
  
  private var userUID : String?
  private let socket:SocketIOClient
  private lazy var eventManagers  = [SocketEventType : EventManager<SocketEvent>]()
  
  
  required init(url:String){
    
    socket = SocketIOClient(socketURL: url)
    super.init()
    addHandlers()
    
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
    if (socket.connected || socket.connecting){
      return
    }
    socket.connect()
  }
  
  func disconnect(){
    socket.close(fast: false)
  }
  
  func addListener(owner:NSObject,
    socketEventType : SocketEventType,
    evaluation:(event:SocketEvent)->Bool,
    callback:(event:SocketEvent)->Void) -> HandlerCallback<SocketEvent>? {
      
      if let manager:EventManager<SocketEvent> = self.eventManagers[socketEventType] {
        return  manager.addListener(owner,evaluation: evaluation,callback: callback)
        
      }
      else{
        return nil
      }
      
  }
  
  /**
  For Objective-C
  */
  func addListener(owner:NSObject,
    socketEventTypeString : String,
    evaluation:(event:SocketEvent)->Bool,
    callback:(event:SocketEvent)->Void) -> Void {
      
      if let socketEventType = SocketEventType(rawValue: socketEventTypeString){
        addListener(owner, socketEventType: socketEventType, evaluation: evaluation, callback: callback)
      }
      
  }
  
  // TODO: Must implement
  func removeListener(#handler:HandlerCallback<SocketEvent>){
    
  }
  
  func removeListener(target:NSObject){
    
    for socketEventType:SocketEventType  in eventManagers.keys{
      removeListener(target, socketEventType: socketEventType)
    }
  }
  
  func removeListener(target:NSObject,socketEventType:SocketEventType){
    
    if let eventManager = eventManagers[socketEventType]{
      eventManager.removeListener(target)
    }
    
  }
  
  func emit(#socketEventType:SocketEventType, event:SocketEvent){
    socket.emit(socketEventType.rawValue, event.jsonDictionary())
  }
  
  func emit(#socketEventType:SocketEventType, payload:PayloadType) -> SocketEvent{
    
    let event = SocketEvent(identifier: "xxx-test", from: "x", to: "y", payload: payload)
    socket.emit(socketEventType.rawValue, event.jsonDictionary())
    return event
    
  }
  
  /**
  For Objective-C
  */
  func emit(#socketEventTypeString:String, payloadData:PayloadBase) -> SocketEvent?{
    
    var payloadType : PayloadType?
    
    if let socketEventType:SocketEventType = SocketEventType(rawValue: socketEventTypeString){
      if let payloadText:PayloadText = payloadData as? PayloadText{
        payloadType = PayloadType.Text(payload: payloadText)
      }
      else if let payloadImage:PayloadImage = payloadData as? PayloadImage{
        payloadType = PayloadType.Image(payload: payloadImage)
      }
      
      if let payloadTypeUnwrapped = payloadType{
        return emit(socketEventType: socketEventType, payload: payloadTypeUnwrapped)
      }
    }
    
    return nil
  }
  
}