//
//  PayloadType.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/6/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation


enum PayloadTypeKey : String {
    case Text = "text"
    case Image = "image"
}

enum PayloadType {
    case Text (payload:PayloadText?)
    case Image (payload:PayloadImage?)
    
    func type() -> String?{
        switch self {
        case .Text:
            return "text"
        case .Image:
            return "image"
        default:
            return nil
            
        }
    }
    
  func jsonDictionary() -> [String : AnyObject]?{
        
        switch self{
        case .Text(let payloadText):
            return payloadText?.jsonDictionary()
        case .Image(let payloadImage):
            return payloadImage?.jsonDictionary()
        default:
            return nil
            
        }
    }
    
    func senderName() -> String?{
        switch self{
        case .Text(let payloadText):
            return payloadText?.senderName
        case .Image(let payloadImage):
            return payloadImage?.senderName
        default:
            return nil
            
        }
    }
    
    func description() -> String? {
        
        switch self{
        case .Text(let payloadText):
            return payloadText?.description
        case .Image(let payloadImage):
            return payloadImage?.description
        default:
            return nil
            
        }
    }
}

