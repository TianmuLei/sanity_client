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

@property (strong,nonatomic) NSMutableArray * budgetArray;
@property (strong,nonatomic) NSMutableArray * amountArray;
@property (strong,nonatomic) NSMutableArray * colors;
@property (strong,nonatomic) BudgetListController * controller;
- (void) setBudget:(NSMutableArray*) budget amount:(NSMutableArray *) amount colors:(NSMutableArray*)color;
- (void) setTexts:(NSMutableArray*) textsArray slices:(NSMutableArray *) slicesArray;

@end
