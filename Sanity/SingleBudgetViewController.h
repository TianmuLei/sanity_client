//
//  ViewControllerTest.h
//  CS310
//
//  Created by Gu on 10/7/17.
//  Copyright © 2017 Gu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"
#import "BudgetListController.h"

@interface SingleBudgetViewController : UIViewController

@property (weak, nonatomic) IBOutlet XYPieChart *PieChartDisplay;
@property (strong,nonatomic) BudgetListController * controller;
@property (nonatomic, strong) NSMutableArray *texts;
@property (nonatomic, strong) NSMutableArray *slices;
@property (nonatomic, strong) NSString * pageTitle;
@property (nonatomic, strong) NSString * additionalInfo;

- (void) setTexts:(NSMutableArray*) textsArray slices:(NSMutableArray*)slicesArray;
- (void) setAdditionalText: (NSString*) text;


@end
