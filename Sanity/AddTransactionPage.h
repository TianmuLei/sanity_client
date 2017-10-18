//
//  AddTransactionPage.h
//  Sanity
//
//  Created by Ruyin Shao on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Budget.h"
#import "AddTransactionController.h"

@interface AddTransactionPage : UITableViewController<AddTransactionControllerDelegate>

- (void) receiveBudgetInfo: (NSMutableArray *) budgetsFromServer;
- (void) addSuccessful;
- (void) addFailed;

@end
