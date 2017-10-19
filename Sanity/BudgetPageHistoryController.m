//
//  BudgetPageHistoryController.m
//  Sanity
//
//  Created by Tianmu on 10/18/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "BudgetPageHistoryController.h"
#import "Budget.h"
#import "Category.h"

@implementation BudgetPageHistoryController
-(void) requestBudget:(NSString*) name period:(int)period{
    Budget* single=[self.client getBudget:name period:period];
    NSMutableArray *name1 = [[NSMutableArray alloc]init];
    NSMutableArray *amount = [[NSMutableArray alloc]init];
    for(int j=0;j<single.categories.count;j++){
        Category* cat=  [single.categories objectAtIndex:j];
        NSString* Catname=cat.name;
        double Catspent=cat.spent;
        double Cattotal=cat.limit;
        NSString* amountString= [NSString stringWithFormat:@"%f/%f",Catspent,Cattotal];
        [amount addObject:amountString];
        [name1 addObject:Catname];
        
    }
    NSLog(@"%@", name1);
    NSLog(@"%@", amount);
    [self.delegate setTexts:name1 slices:amount];

   
    
}
@end
