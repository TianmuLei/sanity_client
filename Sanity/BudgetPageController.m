//
//  BudgetPageController.m
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "BudgetPageController.h"

@implementation BudgetPageController


-(void) requestBudgetList{
    NSDictionary *info=@{@"email":self.client.myUser.email};
    NSDictionary *message=@{@"function":@"requestBudgetList",@"information":info};
    
    [self.client sendMessage:message];
    
}


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


@end
