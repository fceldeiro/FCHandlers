//
//  Event.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation
import SwiftyJSON

class Event {
    
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
        
        if let from = dictionary[Event.kFrom] as? String{
            self.from = from
            
        }
        
        if let to = dictionary[Event.kTo] as? String{
            self.to = to
        }
        
        if let identifier = dictionary[Event.kIdentifier] as? String{
            self.identifier = identifier
        }
        
        if let payload = dictionary[Event.kPayload] as? [String:AnyObject]{
            
        }

        
    }
    init(json:JSON){
        

        self.from = json[Event.kFrom].string
        self.to = json[Event.kTo].string
        self.identifier = json[Event.kIdentifier].string
        
        
        let payloadJSON = json[Event.kPayload]
        if let payloadTypeString:String = payloadJSON["type"].string, let payloadTypeKeyEnum:PayloadTypeKey = PayloadTypeKey(rawValue: payloadTypeString){
            switch payloadTypeKeyEnum{
            case .Text:
                self.payload = PayloadType.Text(payload: PayloadText(json: payloadJSON))
            case .Image:
                self.payload = PayloadType.Image(payload: PayloadImage(json: payloadJSON))
            default:
                self.payload = nil
                
            }
        }
        
    }
    
    func jsonDictionary() -> [String:AnyObject]{
        
        var json = [String:AnyObject]()
        
        if let from = self.from{
            json[Event.kFrom] = from
        }
        
        if let to = self.to{
            json[Event.kTo] = to
        }
        
        if let identifier = self.identifier{
            json[Event.kIdentifier] = identifier
        }
        
        if let payload = self.payload, let payloadDic = payload.jsonDictionary(){
            json[Event.kPayload] = payloadDic
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