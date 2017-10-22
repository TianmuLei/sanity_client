//
//  SingleBudgetHistoryViewController.h
//  Sanity
//
//  Created by Gu on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"
#import "BudgetPageHistoryController.h"

@interface SingleBudgetHistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet XYPieChart *PieChartDisplay;
#warning to be changed to nsarray
#warning texts: NSString / slices spent/budget reload data
@property (nonatomic, strong) NSMutableArray *texts;
@property (nonatomic, strong) NSMutableArray *slices;
@property (nonatomic, strong) NSString * pageTitle;
@property (strong,nonatomic) BudgetPageHistoryController * controller;

- (void) setTexts:(NSMutableArray*) textsArray slices:(NSMutableArray*)slicesArray;
- (void) settingPeriodPicker: (NSMutableArray*) periodArray;

@end
