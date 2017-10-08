//
//  User.h
//  Sanity
//
//  Created by Tianmu on 10/8/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, atomic) NSString* email;
@property (strong, atomic) NSString* username;
@end
