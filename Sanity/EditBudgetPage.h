//
//  EditBudgetPage.h
//  Sanity
//
//  Created by Ruyin Shao on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Budget.h"

@interface EditBudgetPage : UITableViewController
#warning @ziqian data I need a nsstirng of budget name

@property (strong,nonatomic) NSString* budgetName;


- (void) getBudgetInfo:(Budget *)budget;
- (void) deleteCategorySuccess;
- (void) deleteCategoryFail;
- (void) editEntireBudgetSuccess;
- (void) editEntireBudgetFail;

@end
