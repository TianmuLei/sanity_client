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
#import "Currency.h"
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
    int ramainDay=single.remain;
    int period=single.period;
    NSString* info = [NSString stringWithFormat:@"Remaining: $%0.02f, Days Left: %i, Period: %i",remainMoney,ramainDay,period];
    
    
    NSLog(@"%@", name1);
    NSLog(@"%@", amount);
    [self.delegate setTexts:name1 slices:amount];
     NSLog(@"%@", info);
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


-(void) requestCategory:(NSString*) budget category:(NSString*) category{
  Category* actualCat=[self.client getCategory:budget :category];
    NSMutableArray *textArray = [[NSMutableArray alloc]init];
    NSMutableArray *slices = [[NSMutableArray alloc]init];
    NSMutableArray *transName = [[NSMutableArray alloc]init];
    NSMutableArray *transDate = [[NSMutableArray alloc]init];
    NSMutableArray *transAmount = [[NSMutableArray alloc]init];

    //set currency
    Currency* dataModel;
    dataModel = [Currency sharedModel];
    float rate = [dataModel convertFrom:@"USD" To:dataModel.currCurrency];
    
    double spent=actualCat.spent * rate;
    double limit=actualCat.limit * rate;
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
        //set currency
        float amtF = [t.amount floatValue] * rate;
        NSNumber *a= [NSNumber numberWithFloat:amtF];
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
