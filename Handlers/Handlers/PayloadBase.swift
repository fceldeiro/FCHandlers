//
//  PayloadBase.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/6/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import UIKit
import SwiftyJSON

class PayloadBase {
    let type :String
    var senderIdentifier : String? //Variable de prueba
    var senderName : String? //variable de prueba
    
    init (type:String){
        self.type = type
    }
    init (json:JSON){
        self.type = json["type"].string!
        self.senderIdentifier = json["sender_identifier"].string
        self.senderName = json["sender_name"].string

    }
    
    func jsonDictionary() -> Dictionary<String,AnyObject>?{
        
        var dictionary: Dictionary<String,AnyObject> = Dictionary<String,AnyObject>()
        
        dictionary["type"] = self.type;
        
        if (self.senderIdentifier != nil){
            dictionary["sender_identifier" ] = self.senderIdentifier!
        }
        
        if (self.senderName != nil){
            dictionary["sender_name"] = self.senderName
        }
        
        return dictionary
    }
}
