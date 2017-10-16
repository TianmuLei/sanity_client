//
//  AddBudgetController.m
//  Sanity
//
//  Created by Tianmu on 10/14/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "AddBudgetController.h"

@implementation AddBudgetController

-(void) addBudget: (NSString*) name period:(NSNumber*) period date:(NSDateComponents*) startDate category:(NSMutableArray*)category threshold:(NSNumber*) threshold frequency:(NSNumber*) frequency{
    
    NSMutableArray *categoryList = [[NSMutableArray alloc]init];
    
    int budgetTotal=0;
    
    for(int i=0;i<category.count;i++){
        Category* singleCategory=(Category*)[category objectAtIndex:i];
        int limit=singleCategory.limit;
        budgetTotal+=limit;
        NSNumber* limitObject=[[NSNumber alloc]initWithInteger:limit];
        
        
        NSDictionary *jsonCat=@{@"name":singleCategory.name,@"limit":limitObject};
        [categoryList addObject:jsonCat];
        
      
        
    }
    
    NSNumber* totalObject=[[NSNumber alloc]initWithInteger:budgetTotal];
    
    NSInteger year=startDate.year;
    NSInteger month=startDate.month;
    NSInteger day=startDate.day;
    
    NSString* dateString= [NSString stringWithFormat:@"%ld-%ld-%ld",
                           (long)year,(long)month,(long)day];
    
    //NSArray * ArraycategoryList= [categoryList copy];
    //NSLog(@"email:  \"%@\"", self.client.myUser.email);

    NSDictionary *info=@{@"email":self.client.myUser.email,@"name":name,@"period":period,@"budgetTotal":totalObject,@"date":dateString,@"categories":categoryList,@"threshold":threshold,@"frequency":frequency};
    
    
    NSDictionary* message=@{@"function":@"createBudget",@"information":info};
    [self.client sendMessage:message];
    


    
}


@end
