//
//  Payload.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation



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


class Payload{
    let senderIdentifier, senderName : String
    let data : PayloadData
    
    init(senderIdentifier:String,senderName:String,payloadData:PayloadData){
        self.senderIdentifier = senderIdentifier;
        self.senderName = senderName;
        self.data = payloadData;
    }
    
    func description()->String{
        return "SenderId:\(senderIdentifier) - SenderName:\(senderName) - Data:\(data.identifier())"
    }
    
    /*
    init(senderIdentifier:String,senderName:String,data:AnyObject){
        self.senderIdentifier = senderIdentifier;
        self.senderName = senderName;
        self.data = data
    }
    */
}