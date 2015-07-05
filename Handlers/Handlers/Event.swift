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
    var payload : Payload?
    var identifier :String?
    

    init(identifier:String, from:String,to:String,payload:Payload){
       
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
        self.payload = Payload(json: json[Event.kPayload])

        
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
        
        if let payload = self.payload{
            json[Event.kPayload] = payload.jsonDictionary()
        }
        
        return json
    }

    
    
    func description() -> String{
        return "caca"
//        return "From:\(from) - To:\(to) - Identifier:\(identifier) \nPayload: \(payload.description())"
    }
}
