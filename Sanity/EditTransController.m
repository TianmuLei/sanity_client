//
//  EditTransController.m
//  Sanity
//
//  Created by Tianmu on 11/19/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "EditTransController.h"

@implementation EditTransController

-(void) deleteTransaction: (NSNumber*) amount describe:(NSString*) describe category:(NSString*) category budget:(NSString*)budget date:(NSString*) date{
    
       //TO-Do date
    NSDictionary *info=@{@"email":self.client.myUser.email,@"amount":amount,@"description":describe,@"budget":budget,@"category":category,@"date":date};
    NSDictionary *message=@{@"function":@"deleteTransaction",@"information":info};
    
    [self.client sendMessage:message];

    
}

-(void)  editTransaction: (NSNumber*) oldamount olddescribe:(NSString*) olddescribe oldcategory:(NSString*) oldcategory oldbudget:(NSString*)oldbudget newcategory:(NSString*) newcategory newbudget:(NSString*)newbudget olddate:(NSDateComponents*) olddate newamount:(NSNumber*) newamount newdescribe:(NSString*) newdescribe newdate:(NSString*) newdate:(NSString*) newdate {
    

    
    
   
    //TO-Do date
    NSDictionary *info=@{@"email":self.client.myUser.email,@"oldAmount":oldamount,@"oldDescription":olddescribe,@"oldBudget":oldbudget,@"oldCategory":oldcategory,@"newBudget":newbudget,@"newCategory":newcategory,@"oldDate":olddate,@"newAmount":newamount,@"newDescription":newdescribe,@"newDate":newdate};
    NSDictionary *message=@{@"function":@"editTransaction",@"information":info};
    
    [self.client sendMessage:message];

    
    
}

-(Budget*) requestBudget:(NSString*) name{
    return [self.client getBudget:name];
    
}

-(void) requestBudgetAndCate{
    
    [self.delegate receiveBudgetInfo:self.client.budgetListData];
    // NSDictionary *info=@{@"email":self.client.myUser.email};
    // NSDictionary *message=@{@"function":@"budgetAndTransaction",@"information":info};
    // [self.client sendMessage:message];
}



@end
