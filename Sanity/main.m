//
//  main.m
//  Sanity
//
//  Created by Tianmu on 10/5/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import "client.h"
#import "UIClientConnector.h"

int main(int argc, char * argv[]) {
    //client *_clientInstant=[[client alloc] init];
    UIClientConnector *_clientInstant=[[UIClientConnector alloc] init];
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    
    
    
}
