//
//  HistoryHomeTableViewController.h
//  Sanity
//
//  Created by Gu on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BudgetListHistoryController.h"

@interface HistoryHomeTableViewController : UITableViewController
@property (strong,nonatomic) NSArray * budgetArray;
@property (strong,nonatomic) NSArray * amountArray;
@property (strong,nonatomic) NSArray * colors;
@property (strong,nonatomic) BudgetListHistoryController * controller;
- (void) setBudget:(NSArray*) budget amount:(NSArray*) amount colors:(NSArray*)color;
- (void) setTexts:(NSArray*) textsArray slices:(NSArray*) slicesArray;

@end
