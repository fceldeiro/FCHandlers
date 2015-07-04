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
    let callback : () -> Void
    
    init (evaluation:(event:Event) ->Bool, callback:()-> Void){
        self.evaluation = evaluation;
        self.callback = callback;
    }
}
