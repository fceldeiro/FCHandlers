//
//  Generics.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/8/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation

protocol Payload{
    typealias Data
    
    func data() -> Data
}

class PayloadAttachmentText : Payload{
    func data() -> String{
        return "hola"
    }
}

class PayloadAttachmentImage :Payload{
    func data() -> NSURL{
        return NSURL(string: "http://google.com")!
    }
}


class Tester{
    
    func payloadData<T:Payload where T.Data == String> (data:T) -> T.Data{
        return "hola"
    }
    func payloadData<T:Payload where T.Data == NSURL> (data:T) -> T.Data{
        return NSURL(string:"google.com")!
    }
    
    
    
    
}