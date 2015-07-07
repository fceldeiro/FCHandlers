//
//  PayloadImage.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/6/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import UIKit
import SwiftyJSON

class PayloadImage: PayloadBase {
    let imageURL: NSURL?
    
    init (imageURL:NSURL){
        self.imageURL = imageURL
        super.init(type: "image")
    }
    
    override init(json: JSON) {
        
        if let urlString:String = json["image"].string, let imageURL = NSURL(string: urlString){
            self.imageURL = imageURL
            
        }
        else{
            self.imageURL = nil
        }
        
        super.init(json: json)
    }
    
    override func jsonDictionary() -> Dictionary<String,AnyObject>?{
        
        
        var  superDictionary:Dictionary<String,AnyObject>? = super.jsonDictionary()
        if (superDictionary != nil){
            superDictionary!["image"] = self.imageURL?.absoluteString
        }
        
        return superDictionary
        
    }
    
}
