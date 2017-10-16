//
//  Budget.h
//  Sanity
//
//  Created by Tianmu on 10/8/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Budget : NSObject

#warning To tianmu: Changed limit and NSDateComponent to NSDate!!!!! (float threshold)
@property int threshold;//when to push notification
@property float total;
@property int period;
@property (strong, atomic) NSString* name;
@property (strong, atomic) NSMutableArray* categories;
@property (strong, atomic) NSDateComponents* startDate;


@end
