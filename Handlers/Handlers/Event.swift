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
        
        if let from = dictionary["from"] as? String{
            self.from = from
            
        }
        
        if let to = dictionary["to"] as? String{
            self.to = to
        }
        
        if let identifier = dictionary["identifier"] as? String{
            self.identifier = identifier
        }
        
        if let payload = dictionary["payload"] as? [String:AnyObject]{
            
        }

        
    }
    init(json:JSON){
        

        self.from = json["from"].string
        self.to = json["to"].string
        self.identifier = json["identifier"].string
        self.payload = Payload(json: json["payload"])

        
    }
    
    func jsonDictionary() -> [String:AnyObject]{
        
        var json = [String:AnyObject]()
        
        if let from = self.from{
            json["from"] = from
        }
        
        if let to = self.to{
            json["to"] = to
        }
        
        if let identifier = self.identifier{
            json["identifier"] = identifier
        }
        
        if let payload = self.payload{
            json["payload"] = payload.jsonDictionary()
        }
        
        return json
    }

    
    
    func description() -> String{
        return "caca"
//        return "From:\(from) - To:\(to) - Identifier:\(identifier) \nPayload: \(payload.description())"
    }
}
