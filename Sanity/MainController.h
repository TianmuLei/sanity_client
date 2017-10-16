//
//  MainController.h
//  Sanity
//
//  Created by Tianmu on 10/7/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "client.h"



@interface MainController : NSObject
@property (strong, atomic)  client *client;
- (id) initWithClass:(client *)client;
@end
