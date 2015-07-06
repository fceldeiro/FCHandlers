//
//  HandlerCallback.swift
//  Handlers
//
//  Created by Fabian Celdeiro on 7/4/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

import Foundation

class HandlerCallback {
    
    let evaluation : (event:Event) -> Bool
    let callback : (event:Event) -> Void
    
    init (evaluation:(event:Event) ->Bool, callback:(event:Event)-> Void){
        self.evaluation = evaluation
        self.callback = callback
    }
}
