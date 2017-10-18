//
//  SingleCategoryTableViewController.h
//  Sanity
//
//  Created by Gu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleCategoryTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *texts;
@property (nonatomic, strong) NSArray *slices;
@property (nonatomic, strong) NSArray *transactionNames;
@property (nonatomic, strong) NSArray *transactionAmounts;
@property (nonatomic, strong) NSArray *transactionDates;
@property int numOfTransactions;
@property (nonatomic, strong) NSString * textForPieChart; // not in use
@property (nonatomic, strong) NSString * pieChartLabelColor;
@property (nonatomic, strong) NSString * pageTitle;
@property int period;

- (void) setTexts:(NSArray*) textsArray slices:(NSArray*)slicesArray transactionNames:(NSArray*) names transactionAmounts:(NSArray*) amounts transactionDates:(NSArray*)dates numOfTransactions:(int) number labelColor:(NSString*) color;


@end
