//
//  PieChartCategoryViewController.h
//  Sanity
//
//  Created by Gu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryPageController.h"


@interface PieChartCategoryViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *texts;
@property (nonatomic, strong) NSMutableArray *slices;
@property (nonatomic, strong) NSMutableArray *transactionNames;
@property (nonatomic, strong) NSMutableArray *transactionAmounts;
@property (nonatomic, strong) NSMutableArray *transactionDates;
@property int numOfTransactions;
@property (nonatomic, strong) NSString * textForPieChart;
@property (nonatomic, strong) NSString * pieChartLabelColor;
@property (nonatomic, strong) NSString * pageTitle;
@property (strong,nonatomic) CategoryPageController * controller;
@property int period;
@property (nonatomic, strong) NSString * budgetName;
@property (nonatomic, strong) NSMutableArray *longtitude;
@property (nonatomic, strong) NSMutableArray *latitude;

- (void) setTexts:(NSMutableArray *) textsArray slices:(NSMutableArray *)slicesArray transactionNames:(NSMutableArray *) names transactionAmounts:(NSMutableArray *) amounts transactionDates:(NSMutableArray *)dates numOfTransactions:(int) number labelColor:(NSString*)color longtitude:(NSMutableArray *)longtitudeArray latitude:(NSMutableArray *)latitudeArray;

@end
