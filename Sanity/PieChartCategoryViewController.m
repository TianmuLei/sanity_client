//
//  PieChartCategoryViewController.m
//  Sanity
//
//  Created by Gu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "PieChartCategoryViewController.h"
#import "XYPieChart.h"
#import "SingleCategoryTableViewController.h"


@interface PieChartCategoryViewController ()
@property (weak, nonatomic) IBOutlet XYPieChart *PieChartDisplay;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation PieChartCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //set up page title
    self.navigationItem.title = self.pageTitle;
    
    //set up pie chart
    [self.PieChartDisplay setDelegate:self];
    [self.PieChartDisplay setDataSource:self];
    [self.PieChartDisplay setShowPercentage:NO];
    [self.PieChartDisplay setPieBackgroundColor:[UIColor whiteColor]];
    
    //set up string
    self.detailLabel.text = self.textForPieChart;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//for displaying pie chart
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.PieChartDisplay reloadData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


//send parameter to next page by directing changing the values
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ChartCategoryToCategory"]) {
        SingleCategoryTableViewController * destViewController = segue.destinationViewController;
        destViewController.texts = self.texts;
        destViewController.slices = self.slices;
        destViewController.transactionNames = self.transactionNames;
        destViewController.transactionDates = self.transactionDates;
        destViewController.transactionAmounts = self.transactionAmounts;
        destViewController.numOfTransactions = self.numOfTransactions;
        destViewController.textForPieChart = self.textForPieChart;
        destViewController.pieChartLabelColor = self.pieChartLabelColor;
        destViewController.pageTitle = self.pageTitle;
    }
}

#pragma mark - XYPieChart Data Source
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index
{
    return [self.texts objectAtIndex:index];
}

//call back function for delegate
- (void) setTexts:(NSArray*) textsArray slices:(NSArray*)slicesArray transactionNames:(NSArray*) names transactionAmounts:(NSArray*) amounts transactionDates:(NSArray*)dates numOfTransactions:(int) number labelColor:(NSString*) color
{
    self.texts = textsArray;
    self.slices = slicesArray;
    self.transactionNames = names;
    self.transactionAmounts = amounts;
    self.transactionDates = dates;
    self.numOfTransactions = number;
    self.pieChartLabelColor = color;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
