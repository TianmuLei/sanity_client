//
//  BudgetListController.m
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "BudgetListController.h"

@implementation BudgetListController

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

@end
