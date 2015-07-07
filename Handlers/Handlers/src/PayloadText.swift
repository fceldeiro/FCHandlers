//
//  PayloadText.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/6/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import UIKit
import SwiftyJSON

class PayloadText: PayloadBase {
    let text : String?
    
    
    init(text:String){
        self.text = text
        super.init(type: "text")
    }
    override init (json:JSON){
        
        self.text = json["text"].string
        super.init(json:json)
    }
    
    override func jsonDictionary() -> Dictionary<String,AnyObject>?{
        

        var  superDictionary:Dictionary<String,AnyObject>? = super.jsonDictionary()
        if (superDictionary != nil){
            superDictionary!["text"] = self.text
        }
        
        return superDictionary

    }
}
