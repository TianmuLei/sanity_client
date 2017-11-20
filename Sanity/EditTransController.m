//
//  EditTransController.m
//  Sanity
//
//  Created by Tianmu on 11/19/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "EditTransController.h"

@implementation EditTransController

-(void) deleteTransaction: (NSNumber*) amount describe:(NSString*) describe category:(NSString*) category budget:(NSString*)budget date:(NSDateComponents*) date{
    
    NSInteger year=date.year;
    NSInteger month=date.month;
    NSInteger day=date.day;
    
    NSString* dateString= [NSString stringWithFormat:@"%ld-%ld-%ld",
                           (long)year,(long)month,(long)day];
    
    //TO-Do date
    NSDictionary *info=@{@"email":self.client.myUser.email,@"amount":amount,@"description":describe,@"budget":budget,@"category":category,@"date":dateString};
    NSDictionary *message=@{@"function":@"deleteTransaction",@"information":info};
    
    [self.client sendMessage:message];

    
}

-(void) editTransaction: (NSNumber*) oldamount olddescribe:(NSString*) olddescribe category:(NSString*) category budget:(NSString*)budget olddate:(NSDateComponents*) olddate newamount:(NSNumber*) newamount newdescribe:(NSString*) newdescribe newdate:(NSDateComponents*) newdate {
    
    NSInteger year=olddate.year;
    NSInteger month=olddate.month;
    NSInteger day=olddate.day;
    
    NSInteger newyear=newdate.year;
    NSInteger newmonth=newdate.month;
    NSInteger newday=newdate.day;
    
    NSString* dateString= [NSString stringWithFormat:@"%ld-%ld-%ld",
                           (long)year,(long)month,(long)day];
    NSString* newdateString= [NSString stringWithFormat:@"%ld-%ld-%ld",
                           (long)newyear,(long)newmonth,(long)newday];
   
    //TO-Do date
    NSDictionary *info=@{@"email":self.client.myUser.email,@"oldAmount":oldamount,@"oldDescription":olddescribe,@"budget":budget,@"category":category,@"oldDate":dateString,@"newAmount":newamount,@"newDescription":newdescribe,@"newDate":newdateString};
    NSDictionary *message=@{@"function":@"editTransaction",@"information":info};
    
    [self.client sendMessage:message];

    
    
}

-(Budget*) requestBudget:(NSString*) name{
    return [self.client getBudget:name];
    
}

-(void) requestBudgetAndCate{
    
    [self.delegate receiveBudgetInfo:self.client.budgetListData];
    // NSDictionary *info=@{@"email":self.client.myUser.email};
    // NSDictionary *message=@{@"function":@"budgetAndTransaction",@"information":info};
    // [self.client sendMessage:message];
}



@end
