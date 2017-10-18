//
//  AddTransactionController.m
//  Sanity
//
//  Created by Tianmu on 10/14/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "AddTransactionController.h"

@implementation AddTransactionController


-(void) addTransaction: (NSNumber*) amount describe:(NSString*) describe category:(NSString*) category budget:(NSString*)budget date:(NSDateComponents*) date{
    NSInteger year=date.year;
    NSInteger month=date.month;
    NSInteger day=date.day;
    
    NSString* dateString= [NSString stringWithFormat:@"%ld-%ld-%ld",
                         (long)year,(long)month,(long)day];
    
    //TO-Do date
    NSDictionary *info=@{@"email":self.client.myUser.email,@"amount":amount,@"description":describe,@"budget":budget,@"category":category,@"date":dateString};
    NSDictionary *message=@{@"function":@"addTransaction",@"information":info};
    
    [self.client sendMessage:message];

}

-(void) requestBudgetAndCate{
    
    [self.delegate receiveBudgetInfo:self.client.budgetListData];
   // NSDictionary *info=@{@"email":self.client.myUser.email};
   // NSDictionary *message=@{@"function":@"budgetAndTransaction",@"information":info};
   // [self.client sendMessage:message];
}


@end
