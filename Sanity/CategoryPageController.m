//
//  CategoryPageController.m
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "CategoryPageController.h"

@implementation CategoryPageController


-(void) requestBudget:(NSString*) name{
    NSDictionary *info=@{@"email":self.client.myUser.email,@"name":name};
    NSDictionary *message=@{@"function":@"requestBudget",@"information":info};
    [self.client sendMessage:message];
    
}

-(void) requestCategory:(NSString*) budget category:(NSString*) category{
    NSDictionary *info=@{@"email":self.client.myUser.email,@"budget":budget,@"category":category};
    
    NSDictionary *message=@{@"function":@"requestCategory",@"information":info};
    [self.client sendMessage:message];
    
}


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

@end
