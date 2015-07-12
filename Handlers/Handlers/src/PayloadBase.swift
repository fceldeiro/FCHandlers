//
//  PayloadBase.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/6/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import UIKit
import SwiftyJSON


class PayloadBase : NSObject {
  let type :String
  var senderIdentifier : String? //Variable de prueba
  var senderName : String? //variable de prueba
  
  init (type:String){
    self.type = type
  }
  init (json:JSON){
    type = json["type"].string!
    senderIdentifier = json["sender_identifier"].string
    senderName = json["sender_name"].string
    
  }
  
  func jsonDictionary() -> [String : AnyObject] {
    
    var dictionary = [String : AnyObject]()
    
    dictionary["type"] = type;
    
    if (senderIdentifier != nil){
      dictionary["sender_identifier" ] = senderIdentifier!
    }
    
    if (senderName != nil){
      dictionary["sender_name"] = senderName
    }
    
    return dictionary
  }
  
  override var  description: String{
    get {
      return jsonDictionary().description
    }
  }
  
}
