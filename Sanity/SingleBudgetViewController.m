//
//  ViewControllerTest.m
//  CS310
//
//  Created by Gu on 10/7/17.
//  Copyright © 2017 Gu. All rights reserved.
//

#import "SingleBudgetViewController.h"
#import "SingleCategoryTableViewController.h"

@interface SingleBudgetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelTest;
@property (weak, nonatomic) IBOutlet UILabel *labelForClickedElement;

@end

@implementation SingleBudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //for testing purposes
    self.labelTest.text = self.nameSelected;
    //[NSString stringWithFormat:@"%d", (int)self.indexNum];
    
    //set up pie chart
    [self.PieChartDisplay setDelegate:self];
    [self.PieChartDisplay setDataSource:self];
    [self.PieChartDisplay setShowPercentage:NO];
    [self.PieChartDisplay setPieBackgroundColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testClicked:(id)sender
{
    
    [self performSegueWithIdentifier:@"BudgetToCategory" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"BudgetToCategory"]){
        SingleCategoryTableViewController *controller = (SingleCategoryTableViewController *)segue.destinationViewController;
        controller.texts =  @[@"used",@"unused"];
        controller.slices = @[@"50",@"130"];
        controller.transactionNames = @[@"trans1",@"trans2"];
        controller.transactionAmounts = @[@"$100",@"$150"];
        controller.transactionDates = @[@"5/10/2017",@"8/10/2017"];
        controller.numOfTransactions = 2;
        controller.textForPieChart = @"100/200";
        controller.pieChartLabelColor = @"red";
    }
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

#pragma mark - XYPieChart Delegate
//Slice Clicked, change label
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    //display detailed Info
    self.labelForClickedElement.text = [NSString stringWithFormat:@"%@ $%d/$%d",[self.texts objectAtIndex:index],(int)[self.slices objectAtIndex:index],80];
    
    //change text color based on the spending level
    if(rand()%3 == 0)
    {
        self.labelForClickedElement.textColor = [UIColor blackColor];
    }else if(rand()%3 == 1)
    {
        self.labelForClickedElement.textColor = [UIColor orangeColor];
    }else  if(rand()%3 == 2)
    {
        self.labelForClickedElement.textColor = [UIColor redColor];
    }
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
