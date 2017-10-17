//
//  SingleBudgetHistoryViewController.h
//  Sanity
//
//  Created by Gu on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface SingleBudgetHistoryViewController : UIViewController

@property   NSInteger indexNum;
@property   NSString * nameSelected;
@property (weak, nonatomic) IBOutlet XYPieChart *PieChartDisplay;
#warning to be changed to nsarray
@property (nonatomic, strong) NSMutableArray *texts;
@property (nonatomic, strong) NSMutableArray *slices;
@property (strong,nonatomic) NSString * pageTitle;

@end