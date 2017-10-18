//
//  PieChartCategoryViewController.h
//  Sanity
//
//  Created by Gu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>

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
- (void) setTexts:(NSArray*) textsArray slices:(NSArray*)slicesArray transactionNames:(NSArray*) names transactionAmounts:(NSArray*) amounts transactionDates:(NSArray*)dates numOfTransactions:(int) number labelColor:(NSString*) color;

@end
