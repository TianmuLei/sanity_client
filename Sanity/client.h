//
//  client.h
//  Sanity
//
//  Created by Tianmu on 10/5/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <SocketRocket/SRWebSocket.h>

@interface client : NSObject <SRWebSocketDelegate>
@property (strong, atomic)  SRWebSocket *webSocket;
@end

