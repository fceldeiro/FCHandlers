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
    
    func payloadDataType() ->PayloadDataType?{
        
        switch self{
        case .Text(let text):
            return PayloadDataType.Text
        case .Image(let url):
            return PayloadDataType.Image
        default:
            return nil
        }
    }
}

enum PayloadDataType : String{
    case Text = "text"
    case Image = "image"
}



//TODO: Parsing playload data
class Payload{
    
    static let kSenderIdentifier = "sender_identifier"
    static let kSenderName = "sender_name"
    static let kData = "data"
    static let kDataType = "data_type"
    
    
    let senderIdentifier : String?
    let senderName : String?
    var data : PayloadData?
    let dataType : PayloadDataType?
    
    
    
    init(json:JSON){
        
        self.senderIdentifier = json[Payload.kSenderIdentifier].string
        self.senderName = json[Payload.kSenderName].string
        
        
        if let dataTypeString = json[Payload.kDataType].string{
            self.dataType = PayloadDataType(rawValue: dataTypeString)
        }
        else{
            self.dataType = nil
        }
        
        
        var dataToSet : PayloadData?
        
        if let dataType = self.dataType{
            
            switch dataType{
            case .Text:
                if let data = json[Payload.kData].string{
                    dataToSet = PayloadData.Text(text: data)
                }
            case .Image:
                if let data = json[Payload.kData].string, let url = NSURL(string: data){
                    dataToSet = PayloadData.Image(url: url)
                }
            
            default:
                dataToSet = nil
            }
        }
        
        self.data = dataToSet
        
    }
    
    init(senderIdentifier:String,senderName:String,payloadData:PayloadData){
        self.senderIdentifier = senderIdentifier;
        self.senderName = senderName;
        self.data = payloadData;
        self.dataType = payloadData.payloadDataType()
    }
    
    func description()->String{
        
        var desc = String()
        
        if let senderID = self.senderIdentifier{
            desc += "senderIdentifier:\(senderID),"
        }
        
        if let senderName = self.senderName{
            desc += "\nsenderName:\(senderName)"
        }
        
        if let payloadData = self.data{
            switch payloadData{
            case .Text(let text):
                desc += "\ndata:\(text)"
            case .Image(let url):
                desc += "\ndata:\(url)"
            default:
                desc += "\ndata: default"
            }
        }
        
        return desc
  
    }
    
    func jsonDictionary() -> [String:AnyObject]{
        
        var json = [String:AnyObject]()
        
        if let senderIdentifier = self.senderIdentifier{
            json[Payload.kSenderIdentifier] = senderIdentifier
        }
        
        if let senderName = self.senderName{
            json[Payload.kSenderName] = senderName
        }
        
        if let dataType = self.dataType?.rawValue{
            json[Payload.kDataType] = dataType
        }
        
        
        if let data = self.data{
            switch data{
            case .Text(let text):
                json[Payload.kData] = text
            case .Image(let url):
                json[Payload.kData] = url.absoluteString
            default:
                println("data type not valid")
            }
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