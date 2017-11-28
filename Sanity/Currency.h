//
//  Currency.h
//  Sanity
//
//  Created by Ruyin Shao on 11/25/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject

@property (strong,nonatomic) NSMutableDictionary* currencyList;
@property (strong,nonatomic) NSArray* currencyNames;
@property (strong,nonatomic) NSString* currCurrency;
+(instancetype) sharedModel;
- (float) convertFrom:(NSString *) currCurr To: (NSString*)nextCurr;


@end


