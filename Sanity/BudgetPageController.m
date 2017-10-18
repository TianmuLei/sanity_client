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
    NSMutableArray* budgetList=self.client.budgetListDataDic;
    NSMutableArray *name = [[NSMutableArray alloc]init];
    NSMutableArray *amount = [[NSMutableArray alloc]init];
    NSMutableArray *color = [[NSMutableArray alloc]init];
    for(int i=0;i<budgetList.count;i++){
        NSDictionary* budget=[budgetList objectAtIndex:i];
        [name addObject:[budget objectForKey:@"name"]];
        NSNumber* spent=[budget objectForKey:@"budgetSpent"];
        NSNumber* total=[budget objectForKey:@"budgetTotal"];
        NSString* amountString= [NSString stringWithFormat:@"%@/%@",spent,total];
        [amount addObject:amountString];
        [color addObject:@"black"];
        
        
        //NSString *spendT = [NSNumber stringValue];
        
    }
    [self.delegate setBudget:name amount:amount colors:color];
    
}


-(void) requestBudget:(NSString*) name{
   
    
    /*NSDictionary *info=@{@"email":self.client.myUser.email,@"name":name};
    NSDictionary *message=@{@"function":@"requestBudget",@"information":info};
    [self.client sendMessage:message];*/
    
}

-(void) requestCategory:(NSString*) budget category:(NSString*) category{
    NSDictionary *info=@{@"email":self.client.myUser.email,@"budget":budget,@"category":category};
    
    NSDictionary *message=@{@"function":@"requestCategory",@"information":info};
    [self.client sendMessage:message];

}


@end
