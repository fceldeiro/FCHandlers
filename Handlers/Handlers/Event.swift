//
//  Event.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation

class Event {
    let from,to : String
    let payload : Payload
    
    init(from:String,to:String,payload:Payload){
        self.from = from
        self.to = to
        self.payload = payload
    }
}
