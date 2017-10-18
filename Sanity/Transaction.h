//
//  Transaction.h
//  Sanity
//
//  Created by Tianmu on 10/8/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject
@property NSNumber* amount;

@property (strong, atomic) NSDateComponents* date;
@property (strong, atomic) NSString* dateString;

@property (strong, atomic) NSString* budget;
@property (strong, atomic) NSString* category;
@property (strong, atomic) NSString* describe;
@end
