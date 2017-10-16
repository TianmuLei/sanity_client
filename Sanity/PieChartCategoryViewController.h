//
//  PieChartCategoryViewController.h
//  Sanity
//
//  Created by Gu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartCategoryViewController : UIViewController
@property (nonatomic, strong) NSArray *texts;
@property (nonatomic, strong) NSArray *slices;
@property (nonatomic, strong) NSArray *transactionNames;
@property (nonatomic, strong) NSArray *transactionAmounts;
@property (nonatomic, strong) NSArray *transactionDates;
@property int numOfTransactions;
@property (nonatomic, strong) NSString * textForPieChart;
@property (nonatomic, strong) NSString * pieChartLabelColor;


@end
