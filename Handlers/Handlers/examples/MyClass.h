//
//  MyClass.h
//  Handlers
//
//  Created by Fabian Celdeiro on 7/8/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

#import <Foundation/Foundation.h>


@class SocketManager;

@interface MyClass : NSObject
-(void) test;
-(void) testWithSocket:(SocketManager*) manager;
@end
