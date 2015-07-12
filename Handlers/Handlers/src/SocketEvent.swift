//
//  SocketEvent
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation
import SwiftyJSON

class SocketEvent {
  
  static let kFrom = "from"
  static let kTo = "to"
  static let kIdentifier = "identifier"
  static let kPayload = "payload"
  
  
  var from : String?
  var to : String?
  var payload : PayloadType?
  var identifier :String?
  
  
  init(identifier:String, from:String,to:String,payload:PayloadType){
    
    self.from = from
    self.to = to
    self.identifier = identifier;
    self.payload = payload
  }
  
  
  init(dictionary:[String:AnyObject]){
    
    if let from = dictionary[SocketEvent.kFrom] as? String{
      self.from = from
      
    }
    
    if let to = dictionary[SocketEvent.kTo] as? String{
      self.to = to
    }
    
    if let identifier = dictionary[SocketEvent.kIdentifier] as? String{
      self.identifier = identifier
    }
    
    if let payload = dictionary[SocketEvent.kPayload] as? [String:AnyObject]{
      
    }
    
    
  }
  init(json:JSON){
    
    
    from = json[SocketEvent.kFrom].string
    to = json[SocketEvent.kTo].string
    identifier = json[SocketEvent.kIdentifier].string
    
    
    let payloadJSON = json[SocketEvent.kPayload]
    if let payloadTypeString:String = payloadJSON["type"].string, let payloadTypeKeyEnum:PayloadTypeKey = PayloadTypeKey(rawValue: payloadTypeString){
      switch payloadTypeKeyEnum{
      case .Text:
        payload = PayloadType.Text(payload: PayloadText(json: payloadJSON))
      case .Image:
        payload = PayloadType.Image(payload: PayloadImage(json: payloadJSON))
      default:
        payload = nil
        
      }
    }
    
  }
  
  func jsonDictionary() -> [String:AnyObject]{
    
    var json = [String:AnyObject]()
    
    if let from = self.from{
      json[SocketEvent.kFrom] = from
    }
    
    if let to = self.to{
      json[SocketEvent.kTo] = to
    }
    
    if let identifier = self.identifier{
      json[SocketEvent.kIdentifier] = identifier
    }
    
    if let payload = self.payload, let payloadDic = payload.jsonDictionary(){
      json[SocketEvent.kPayload] = payloadDic
    }
    
    return json
  }
  
  
  var description : String {
    get {
      
      var desc = String()
      
      if let from = self.from{
        desc += "from:\(from) ,"
      }
      
      if let to = self.to{
        desc += "\nto:\(to) ,"
      }
      
      if let identifier = self.identifier{
        desc += "\nidentifier:\(identifier) ,"
      }
      
      
      if let payloadDescription = self.payload?.description(){
        desc += "\npayload:{\n\(payloadDescription)\n}"
      }
      
      
      return desc
    }
  }
  
}
