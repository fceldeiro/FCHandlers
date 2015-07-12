//
//  MyClass.m
//  Handlers
//
//  Created by Fabian Celdeiro on 7/8/15.
//  Copyright (c) 2015 Fabian Celdeiro. All rights reserved.
//

#import "MyClass.h"
#import "Handlers-Swift.h"


@implementation MyClass
-(void) test{
  SocketManager  * manager = [[SocketManager alloc] init];
 
  [manager addListener:self socketEventTypeString:@"message" evaluation:^BOOL(SocketEvent * event) {
    return YES;
  } callback:^(SocketEvent * event) {
    NSLog(@"%@",event);
    NSLog(@"%@",NSStringFromClass(event.payloadData.class));
  }];
  

}
-(void) testWithSocket:(SocketManager*) manager{
  [manager addListener:self socketEventTypeString:@"message" evaluation:^BOOL(SocketEvent * event) {
    return YES;
  } callback:^(SocketEvent * event) {
    NSLog(@"%@",event);
    NSLog(@"%@",NSStringFromClass(event.payloadData.class));
  }];
  
  PayloadText * payloadText = [[PayloadText alloc] initWithText:@"TU VIEJA"];
  
  [manager emitWithSocketEventTypeString:@"message" payloadData:payloadText];
}
@end
