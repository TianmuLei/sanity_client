//
//  Transaction.h
//  Sanity
//
//  Created by Tianmu on 10/8/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Transaction : NSObject
@property int* amount;
@property (strong, atomic) NSString* des;
@property (strong, atomic) NSDateComponents* date;
@property (strong, atomic) NSString* budget;
@property (strong, atomic) NSString* category;

@end
