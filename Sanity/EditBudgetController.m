//
//  EditBudgetController.m
//  Sanity
//
//  Created by Tianmu on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "EditBudgetController.h"

@implementation EditBudgetController

- (void) editBudget :(NSString*) oldBudgetName withnewBudget:(NSString *)newBudgetName withPeriod:(NSString*) period withThreshold:(NSString*)threshold withFrequency:(NSString*)frequency{
    NSNumber* num=@100;
    NSMutableArray *categoryList = [[NSMutableArray alloc]init];

    NSDictionary *info=@{@"email":self.client.myUser.email,@"oldName":oldBudgetName,@"name":newBudgetName,@"period":period,@"budgetTotal":num,@"threshold":threshold,@"frequency":frequency,@"categories":categoryList,@"date":@"2017-10-18"};
    
    
    NSDictionary* message=@{@"function":@"editBudget",@"information":info};
    [self.client sendMessage:message];

    
    
}


-(void) success{
    [self.delegate editEntireBudgetSuccess];
    
}
-(void) fail{
    [self.delegate editEntireBudgetFail];

}

@end
