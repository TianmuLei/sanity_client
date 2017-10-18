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

@implementation CategoryPageController


-(void) requestBudget:(NSString*) name{
    NSDictionary *info=@{@"email":self.client.myUser.email,@"name":name};
    NSDictionary *message=@{@"function":@"requestBudget",@"information":info};
    [self.client sendMessage:message];
    
}

-(void) requestCategory:(NSString*) budget category:(NSString*) category{
    Category* actualCat=[self.client getCategory:budget :category];
    if(actualCat==nil){
        NSLog(@"THIS IS NULL");
    }
    NSMutableArray *textArray = [[NSMutableArray alloc]init];
    NSMutableArray *slices = [[NSMutableArray alloc]init];
   NSMutableArray *transName = [[NSMutableArray alloc]init];
    NSMutableArray *transDate = [[NSMutableArray alloc]init];
    NSMutableArray *transAmount = [[NSMutableArray alloc]init];

    
 //   NSMutableArray* transName=@[@"a"];
   // NSMutableArray* transDate=@[@"a"];
    //NSMutableArray* transAmount=@[@"a"];
    
    double spent=actualCat.spent;
    double limit=actualCat.limit;
    double remain=limit-spent;
    if(remain<0){
        remain=1;
    }
    NSString *spentString=[NSString stringWithFormat:@"%f", spent];
    NSString *remianString=[NSString stringWithFormat:@"%f", remain];
    
    [textArray addObject:@"Spent"];
    [textArray addObject:@"Left"];
    [slices addObject:spentString];
    [slices addObject:remianString];
    NSLog(@"%@", spentString);
    NSLog(@"%@", remianString);
    NSMutableArray *trans=actualCat.transctions;
    
    
    for(int j=0;j<trans.count;j++){
        Transaction* t=[trans objectAtIndex:j];
        [transName addObject:t.describe];
        NSNumber *a=t.amount;
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

@end
