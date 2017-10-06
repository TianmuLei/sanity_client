//
//  client.m
//  Sanity
//
//  Created by Tianmu on 10/5/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "client.h"

@implementation client
- (instancetype)init
{
    self = [super init];
    if (self) {
        _webSocket = [[SRWebSocket alloc] initWithURL:[NSURL URLWithString:@"ws://localhost:9999"]];
        _webSocket.delegate = self;
        [_webSocket open];
        
        
        
        
        
    }
    return self;
}


- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
    NSString *message = @"WangWangWang";
    [_webSocket send:message];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(nonnull NSString *)string
{
    NSLog(@"Received \"%@\"", string);
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload;
{
    NSLog(@"WebSocket received pong");
}



- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"WebSocket received message");
    NSString *myString = (NSString *)message;
    NSLog(@"message \"%@\"", myString);
    
}

@end

