//
//  Category.h
//  Sanity
//
//  Created by Tianmu on 10/8/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject


@property double limit;
@property double spent;
@property (strong, atomic) NSString* name;
@property (strong, atomic) NSString* budget;
@property (strong, atomic) NSMutableArray* transctions;

@end
