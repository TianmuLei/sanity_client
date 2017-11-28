//
//  BudgetListController.m
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "BudgetListController.h"
#include "Category.h"
#include "Budget.h"
#include "Currency.h"


@implementation BudgetListController


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
        
        //set currency
        Currency* dataModel;
        dataModel = [Currency sharedModel];
        float rate = [dataModel convertFrom:@"USD" To:dataModel.currCurrency];
        float spentf = [spent floatValue] * rate;
        float totalf = [total floatValue] * rate;
        
        
        NSString* amountString= [NSString stringWithFormat:@"%.02f/%.02f",spentf,totalf];
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


-(void) requestBudget:(NSString*) name{
    Budget* single=[self.client getBudget:name];
    NSMutableArray *name1 = [[NSMutableArray alloc]init];
    NSMutableArray *amount = [[NSMutableArray alloc]init];
    
    //set currency
    Currency* dataModel;
    dataModel = [Currency sharedModel];
    float rate = [dataModel convertFrom:@"USD" To:dataModel.currCurrency];
   
    for(int j=0;j<single.categories.count;j++){
        Category* cat=  [single.categories objectAtIndex:j];
        NSString* Catname=cat.name;
        double Catspent=cat.spent * rate;
        double Cattotal=cat.limit * rate;
        NSString* amountString= [NSString stringWithFormat:@"%.02f/%.02f",Catspent,Cattotal];
        [amount addObject:amountString];
        [name1 addObject:Catname];
        
    }
    
    float remainMoney= (single.total-single.spent) * rate;
    int ramainDay=single.remainNew;
    int period=single.period;
    NSString* info = [NSString stringWithFormat:@"Remaining: $%0.02f, Days Left: %i, Period: %i",remainMoney,ramainDay,period];
    
    NSLog(@"remainDays %i", ramainDay);
    NSLog(@"%@", name1);
     NSLog(@"%@", amount);
    [self.delegate setTexts:name1 slices:amount];
    [self.delegate setAdditionalText:info];


}

-(void) requestSummary:(NSString*) name{
    NSDictionary *info=@{@"email":self.client.myUser.email,@"budgetName":name};
    
    NSDictionary *message=@{@"function":@"requestSummary",@"information":info};
    
    [self.client sendMessage:message];
    
    
}

-(void) shareBudget:(NSString*) budgetName budget:(NSString*)emailShare{
    NSDictionary *info=@{@"email":self.client.myUser.email,@"budgetName":budgetName,@"emailShare":emailShare};
    
    NSDictionary *message=@{@"function":@"shareBudget",@"information":info};
    
    [self.client sendMessage:message];
}



@end
