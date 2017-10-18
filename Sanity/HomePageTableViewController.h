//
//  HomePageTableViewController.h
//  CS310
//
//  Created by Gu on 10/6/17.
//  Copyright © 2017 Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BudgetListController.h"

@interface HomePageTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSArray * budgetArray;
@property (strong,nonatomic) NSArray * amountArray;
@property (strong,nonatomic) NSArray * colors;
@property (strong,nonatomic) BudgetListController * controller;
- (void) setBudget:(NSArray*) budget amount:(NSArray*) amount colors:(NSArray*)color;
- (void) setTexts:(NSArray*) textsArray slices:(NSArray*) slicesArray;

@end
