//
//  BudgetPageController.h
//  Sanity
//
//  Created by Tianmu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"

@protocol  BudgetPageControllerDelegate<NSObject>
//add call back function here
@required
@end

@interface BudgetPageController : MainController{
    id <BudgetPageControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) requestBudgetList;
-(void) requestBudget:(NSString*) name;
-(void) requestCategory:(NSString*) budget category:(NSString*) category;
@end
