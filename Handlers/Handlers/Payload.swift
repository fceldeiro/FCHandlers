//
//  Payload.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation



enum PayloadData {
    case PayloadDataText (text:String)
    case PayloadDataImage (url:NSURL)
    case PayloadDataCustom (customPayload:CustomPayloadData)
    
    func identifier() ->String{
        
        switch self{
        case .PayloadDataText(let text):
            return "text"
        case .PayloadDataImage(let url):
            return "image"
        case .PayloadDataCustom(let customPayload):
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