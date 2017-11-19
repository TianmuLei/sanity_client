//
//  EditTransaction.h
//  Sanity
//
//  Created by Ruyin Shao on 11/18/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddTransactionController.h"

@interface EditTransaction : UITableViewController<AddTransactionControllerDelegate>

@property NSString *oldbudget;
@property NSString *oldcategory;
@property NSString *oldAmount;
@property NSString *dateText;
@property NSString *olddescrip;
@end
