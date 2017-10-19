//
//  BudgetListHistoryController.m
//  Sanity
//
//  Created by Tianmu on 10/18/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "BudgetListHistoryController.h"

@implementation BudgetListHistoryController

-(void) requestBudgetList{
    NSMutableArray* budgetList=[self.client.budgetListDataDic objectAtIndex:0];
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
        if(spent>total){
            [color addObject:@"red"];
            
        }
        else{
            [color addObject:@"black"];
            
        }

        
        
        //NSString *spendT = [NSNumber stringValue];
        
    }
    
    
    [self.delegate setBudget:name amount:amount colors:color];
    
}

@end
