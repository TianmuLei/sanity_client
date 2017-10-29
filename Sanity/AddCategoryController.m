//
//  AddCategoryController.m
//  Sanity
//
//  Created by Tianmu on 10/28/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "AddCategoryController.h"

@implementation AddCategoryController
-(void) addCategory:(NSString*) budgetName :(NSString*)categoryName :(NSNumber*)limit{
    NSDictionary *info=@{@"email":self.client.myUser.email,@"budgetName":budgetName,@"categoryName":categoryName,@"limit":limit };
    NSDictionary* message=@{@"function":@"addCategory",@"information":info};
    [self.client sendMessage:message];
}
@end
