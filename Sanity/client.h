//
//  client.h
//  Sanity
//
//  Created by Tianmu on 10/5/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <SocketRocket/SRWebSocket.h>
#import "User.h"

@interface client : NSObject <SRWebSocketDelegate>
@property (strong, atomic)  SRWebSocket *webSocket;
@property (strong, atomic)  User *myUser;
-(NSString*) JSONToString:(NSDictionary*)dict;
-(NSDictionary*) StringToJSON:(NSString*) JSONString;
-(void) sendMessage:(NSDictionary*)dict;
@end

