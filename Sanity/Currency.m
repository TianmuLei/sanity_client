//
//  Currency.m
//  Sanity
//
//  Created by Ruyin Shao on 11/25/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "Currency.h"

@implementation Currency

+(instancetype) sharedModel{
    static Currency *_sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
        
    });
    
    return _sharedModel;
}

-(instancetype) init {
    //initializing arrays
    self = [super init];
    self.currencyList = [[NSMutableDictionary alloc] init];
    self.currencyNames = [[NSMutableArray alloc] init];
    // Setting URL
    NSString *url = [NSString stringWithFormat: @"https://v3.exchangerate-api.com/bulk/cda018463cbedf2bda2dcfef/USD"];
    
    // Fetching
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    NSError *err;
    NSMutableDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    self.currencyNames = [[json objectForKey:@"rates"] allKeys];
    self.currencyList = [json objectForKey:@"rates"];
    self.currCurrency = @"USD";
    return self;
}


- (float) convertFrom:(NSString *) currCurr To: (NSString*)nextCurr{
    // Setting URL
    currCurr = @"USD";
    float rate = [[self.currencyList objectForKey:nextCurr] floatValue];
    self.currCurrency = nextCurr;
    // Your JSON
   // NSLog(@"json: %@", json);
    return rate;
    
}
@end
