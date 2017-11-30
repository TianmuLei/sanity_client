//
//  CategoryPageController.m
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "CategoryPageController.h"
#import "Transaction.h"
#import "Category.h"
#import "Currency.h"

@implementation CategoryPageController


-(void) requestBudget:(NSString*) name{
    NSDictionary *info=@{@"email":self.client.myUser.email,@"name":name};
    NSDictionary *message=@{@"function":@"requestBudget",@"information":info};
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
        [transDate addObject:t.dateString];
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

-(void) requestCategory:(NSString*) budget category:(NSString*) category period:(int)period{
    
    Category* actualCat=[self.client getCategory:budget :category period:period];
    if(actualCat==nil){
        NSLog(@"THIS IS NULL");
    }
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
        [transDate addObject:t.dateString];
    }
    NSString* color;
    if(spent>limit){
        color=@"red";
    }else{
        color=@"black";
    }
    
    NSLog(@"%@", transName );
    
    NSLog(@"%@", transAmount);
    [self.delegate setTexts:textArray slices:slices transactionNames:transName transactionAmounts:transAmount transactionDates:transDate numOfTransactions:trans.count labelColor:color];
    
    
}

@end
