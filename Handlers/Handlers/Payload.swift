//
//  Payload.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation
import SwiftyJSON

enum PayloadData {
    case Text (text:String)
    case Image (url:NSURL)
    case Custom (customPayload:CustomPayloadData)
    
    func identifier() ->String{
        
        switch self{
        case .Text(let text):
            return "text"
        case .Image(let url):
            return "image"
        case .Custom(let customPayload):
            return "action"
        default:
            return "undefined"
        }
    }
}

//TODO: Parsing playload data
class Payload{
    let senderIdentifier : String?
    let senderName : String?
    var data : PayloadData
    
    
    
    init(json:JSON){
        
        self.senderIdentifier = json["sender_identifier"].string
        self.senderName = json["sender_name"].string
        
        self.data = PayloadData.Text(text: "test")
        
    }
    
    init(senderIdentifier:String,senderName:String,payloadData:PayloadData){
        self.senderIdentifier = senderIdentifier;
        self.senderName = senderName;
        self.data = payloadData;
    }
    
    func description()->String{
        return "descrittion";
        //return "SenderId:\(senderIdentifier) - SenderName:\(senderName) - Data:\(data.identifier())"
    }
    
    func jsonDictionary() -> [String:AnyObject]{
        
        var json = [String:AnyObject]()
        
        if let senderIdentifier = self.senderIdentifier{
            json["sender_identifier"] = senderIdentifier
        }
        
        if let senderName = self.senderName{
            json["sender_name"] = senderName
        }
        
        return json
    }
    
    /*
    init(senderIdentifier:String,senderName:String,data:AnyObject){
        self.senderIdentifier = senderIdentifier;
        self.senderName = senderName;
        self.data = data
    }
    */
}