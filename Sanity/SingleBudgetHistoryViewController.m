//
//  SingleBudgetHistoryViewController.m
//  Sanity
//
//  Created by Gu on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "SingleBudgetHistoryViewController.h"
#import "SingleCategoryTableViewController.h"
#import "BudgetPageController.h"
#import "UIClientConnector.h"
#import "PieChartCategoryViewController.h"
#import "Budget.h"

@interface SingleBudgetHistoryViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *labelTest;
@property (weak, nonatomic) IBOutlet UILabel *labelForClickedElement;
@property (weak, nonatomic) IBOutlet UITextField *periodTF;
@property UIPickerView *periodPicker;
@property (strong, nonatomic) NSMutableArray *periods;


@property BOOL periodSelected;
@property int indexClicked;
@property int numOfClicks;
@property int previousIndexClicked;

@property (strong,nonatomic) BudgetPageController * BudgetPagecontroller;

@end

@implementation SingleBudgetHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set title
    self.navigationItem.title = self.pageTitle;
    //set up pie chart
    [self.PieChartDisplay setDelegate:self];
    [self.PieChartDisplay setDataSource:self];
    [self.PieChartDisplay setShowPercentage:NO];
    [self.PieChartDisplay setPieBackgroundColor:[UIColor whiteColor]];
    
    //request info of picker
    //call function
    self.periods = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    self.periodPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.periodPicker.delegate = self;
    self.periodPicker.dataSource = self;
    self.periodPicker.showsSelectionIndicator = YES;
    
    _periodTF.inputView = _periodPicker;
    
    //set up delegate
    self.controller = UIClientConnector.myClient.budgetPageHistory;
    UIClientConnector.myClient.budgetPageHistory.delegate = self;
    [self.controller requestBudget:self.pageTitle period:1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissPicker:(id)sender {
    [self.periodTF endEditing:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SingleBudgetHistoryToCategory"]){
        PieChartCategoryViewController *controller = (PieChartCategoryViewController *)segue.destinationViewController;
        
        controller.texts = [NSMutableArray arrayWithObjects:@"spent",@"left",nil];
        controller.slices = [NSMutableArray arrayWithObjects:@"50",@"130",nil];
        controller.transactionNames = [NSMutableArray arrayWithObjects:@"trans1",@"trans2",nil];
        controller.transactionAmounts = [NSMutableArray arrayWithObjects:@"$100",@"$150",nil];
        controller.transactionDates = [NSMutableArray arrayWithObjects:@"5/10/2017",@"8/10/2017",nil];
        controller.numOfTransactions = 2;
        controller.textForPieChart = @"100/200";
        controller.pieChartLabelColor = @"red";
        
        
        controller.textForPieChart = self.slices[self.indexClicked];
        controller.pageTitle = self.texts[self.indexClicked];
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
        [self performSegueWithIdentifier:@"SingleBudgetHistoryToCategory" sender:self];
    }
    
}

- (void)pieChart:(XYPieChart *)pieChart didDeselectSliceAtIndex:(NSUInteger)index;
{
    //count number of clicks
    self.numOfClicks++;
    self.previousIndexClicked = (int)index;
}


/*For setting up period Picker*/

#pragma mark - UIPickerViewDataSource
// #3
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.periodPicker) {
        return 1;
    }
    return 0;
}

// #4
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.periodPicker) {
        if (_periodTF.text.length < 1) {
            _periodSelected = NO;
        }
        return [self.periods count];
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate

// #5
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.periodPicker) {
        _periodSelected = YES;
#warning cast to period var? whats the format?
        return _periods[row];
    }
    return nil;
}

// #6
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.periodPicker) {
        //need controller
        self.periodTF.text = _periods[row];
        
        [self.periodTF endEditing:YES];
        
        [_controller requestBudget:_pageTitle period:[_periods[row] intValue]];
#warning reload here
        
    }
    
}

- (void) settingPeriodPicker:(NSMutableArray *)periodArray {
    self.periods = [[NSMutableArray alloc] init];
    self.periods = periodArray;
    
}


//call back function for delegate
- (void) setTexts:(NSMutableArray*) textsArray slices:(NSMutableArray *)slicesArray
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
