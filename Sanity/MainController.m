//
//  MainController.m
//  Sanity
//
//  Created by Tianmu on 10/7/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"

@implementation MainController


- (id) initWithClass:(client *)myClient{
    self = [super init];
    if (self) {
        self.client=myClient;
    }
    return self;
}

@end
