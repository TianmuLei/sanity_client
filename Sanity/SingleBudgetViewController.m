//
//  ViewControllerTest.m
//  CS310
//
//  Created by Gu on 10/7/17.
//  Copyright © 2017 Gu. All rights reserved.
//

#import "SingleBudgetViewController.h"
#import "UIClientConnector.h"
#import "PieChartCategoryViewController.h"
#import "EditBudgetPage.h"

@interface SingleBudgetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelTest;
@property (weak, nonatomic) IBOutlet UILabel *labelForClickedElement;
@property int indexClicked;
@property int numOfClicks;
@property int previousIndexClicked;

@end

@implementation SingleBudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set title
    self.navigationItem.title = self.pageTitle;
    self.slices = [[NSMutableArray alloc] init];
    self.texts = [[NSMutableArray alloc] init];
    
    //set up delegate
    self.controller = UIClientConnector.myClient.budgetList;
    UIClientConnector.myClient.budgetList.delegate = self;
    //to get data
    [self.controller requestBudget:self.pageTitle];
    
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"BudgetToCategory"]){
        NSLog(@"send data");
        PieChartCategoryViewController *controller = (PieChartCategoryViewController *)segue.destinationViewController;
        
        /*
        controller.texts =  [NSMutableArray arrayWithObjects: @"spent",@"left",nil];
        controller.slices = [NSMutableArray arrayWithObjects: @"50",@"130",nil];
        controller.transactionNames = [NSMutableArray arrayWithObjects: @"trans1",@"trans2",nil];
        controller.transactionAmounts = [NSMutableArray arrayWithObjects: @"$100",@"$150",nil];
        controller.transactionDates = [NSMutableArray arrayWithObjects:@"5/10/2017",@"8/10/2017",nil];
        controller.numOfTransactions = 2;
        controller.textForPieChart = @"100/200";
        controller.pieChartLabelColor = @"red";
        */
        
        //to get values
        NSArray *array = [[self.slices objectAtIndex:self.indexClicked] componentsSeparatedByString:@"/"];
        //display detailed Info
        controller.textForPieChart = [NSString stringWithFormat:@"%.02f/%.02f",[[array objectAtIndex:0] floatValue],[[array objectAtIndex:1] floatValue] ] ;
        
        
        controller.pageTitle = self.texts[self.indexClicked];
        controller.period = 0;
        controller.budgetName = self.pageTitle;
    }else if([segue.identifier isEqualToString:@"BudgetToEditBudget"]){
        EditBudgetPage *controller = (EditBudgetPage *)segue.destinationViewController;
        controller.budgetName = self.pageTitle;
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

- (IBAction)sendSummary:(id)sender {
}

#pragma mark - XYPieChart Data Source
- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    NSArray *array = [[self.slices objectAtIndex:index] componentsSeparatedByString:@"/"];
    //NSLog(@"%@",[array objectAtIndex:1]);
    return [[array objectAtIndex:1] intValue];
    //return [[self.slices objectAtIndex:index] intValue];
}

- (NSString *)pieChart:(XYPieChart *)pieChart textForSliceAtIndex:(NSUInteger)index
{
    return [self.texts objectAtIndex:index];
}

#pragma mark - XYPieChart Delegate
//Slice Clicked, change label
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    self.indexClicked = (int)index;
    //for getting values
    NSArray *array = [[self.slices objectAtIndex:index] componentsSeparatedByString:@"/"];
    //display detailed Info
    self.labelForClickedElement.text = [NSString stringWithFormat:@"%@,   %.02f/%.02f",[self.texts objectAtIndex:index],[[array objectAtIndex:0] floatValue],[[array objectAtIndex:1] floatValue] ] ;
    
    //change text color based on the spending level
    if([[array objectAtIndex:0] floatValue] > [[array objectAtIndex:1] floatValue])
    {
        self.labelForClickedElement.textColor = [UIColor redColor];
        
    }else{
        self.labelForClickedElement.textColor = [UIColor blackColor];
    }
    
    /*else if(rand()%3 == 1)
    {
        self.labelForClickedElement.textColor = [UIColor orangeColor];
    }else  if(rand()%3 == 2)
    {
        
    }*/
    
    if(self.numOfClicks == 0){
        //first click, don't redirect
        self.numOfClicks = 1;
    }else if( self.numOfClicks == 2 && self.previousIndexClicked!=(int)index)
    {
        //third click with different element, don't redirect
        _numOfClicks = 1;
    }else if( self.numOfClicks == 2 && self.previousIndexClicked==(int)index)
    {
        //third click with same element, redirect
        self.numOfClicks = 0;
        self.previousIndexClicked = -1;
        NSLog(@"perform segue");
        [self performSegueWithIdentifier:@"BudgetToCategory" sender:self];
    }
}

- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index;
{
    //count number of clicks
    self.numOfClicks++;
    self.previousIndexClicked = (int)index;
}


//call back function for delegate
- (void) setTexts:(NSMutableArray *) textsArray slices:(NSMutableArray *)slicesArray
{
    self.texts = textsArray;
    self.slices = slicesArray;
    [self.PieChartDisplay reloadData];
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
