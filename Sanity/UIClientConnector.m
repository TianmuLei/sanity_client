//
//  UIClientConnector.m
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "UIClientConnector.h"

@implementation UIClientConnector

static client *myClient=nil;

+(void) initialize
{
    if (! myClient)
       myClient = [[client alloc] init];
}

+ (client *)myClient
{
    return myClient;
}


+ (void) setMyClient:(client *)new
{
    if( myClient!= new) {
        myClient= [new copy];
    }
}

@end
