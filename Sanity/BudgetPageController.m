//
//  BudgetPageController.m
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "BudgetPageController.h"
#import "Category.h"
#import "Budget.h"
#import "Transaction.h"

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
    Budget* single=[self.client getBudget:name];
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

-(void) requestSummary:(NSString*) name{
    NSDictionary *info=@{@"email":self.client.myUser.email,@"budgetName":name};
    
    NSDictionary *message=@{@"function":@"requestSummary",@"information":info};
    
    [self.client sendMessage:message];
    

}


-(void) requestCategory:(NSString*) budget category:(NSString*) category{
  Category* actualCat=[self.client getCategory:budget :category];
    NSMutableArray *textArray = [[NSMutableArray alloc]init];
    NSMutableArray *slices = [[NSMutableArray alloc]init];
    NSMutableArray *transName = [[NSMutableArray alloc]init];
    NSMutableArray *transDate = [[NSMutableArray alloc]init];
    NSMutableArray *transAmount = [[NSMutableArray alloc]init];

    double spent=actualCat.spent;
    double limit=actualCat.limit;
    double remain=limit-spent;
    NSString *spentString=[NSString stringWithFormat:@"%f", spent];
    NSString *remianString=[NSString stringWithFormat:@"%f", remain];
    
    [textArray addObject:@"spent"];
    [textArray addObject:@"left"];
    [slices addObject:spentString];
    [slices addObject:remianString];
    NSMutableArray *trans=actualCat.transctions;
    for(int j=0;j<trans.count;j++){
        Transaction* t=[trans objectAtIndex:j];
        [transName addObject:t.describe];
        NSNumber *a=t.amount;
        NSString *aS=[a stringValue];
        [transAmount addObject:aS];
        [transDate addObject:t.date];
    }
    NSString* color;
    if(spent>limit){
        color=@"red";
    }else{
        color=@"black";
    }
    [self.delegate setTexts:textArray slices:slices transactionNames:transName transactionAmounts:transAmount transactionDates:transDate numOfTransactions:trans.count labelColor:color];

    
    
    
   /* - (void) setTexts:(NSArray*) textsArray slices:(NSArray*)slicesArray transactionNames:(NSArray*) names transactionAmounts:(NSArray*) amounts transactionDates:(NSArray*)dates numOfTransactions:(int) number labelColor:(NSString*) color;

   */
    
    
}


@end
