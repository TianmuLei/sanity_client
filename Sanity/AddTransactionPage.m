//
//  AddTransactionPage.m
//  Sanity
//
//  Created by Ruyin Shao on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "AddTransactionPage.h"
#import "Budget.h"
#import "Category.h"
#import "UIClientConnector.h"
#import "AddTransactionController.h"
#import "AppDelegate.h"


@interface AddTransactionPage () <UIPickerViewDelegate, UIPickerViewDataSource>

//UI Elements
@property (weak, nonatomic) IBOutlet UITextField *budgetTF;
@property (weak, nonatomic) IBOutlet UIDatePicker *date;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UITextField *categoryTF;
@property (weak, nonatomic) IBOutlet UITextField *descripTF;
@property UIPickerView *budgetPicker;
@property UIPickerView *categoryPicker;

//Arrays
@property (strong, nonatomic) NSMutableArray *budgets;
@property (strong, nonatomic) NSMutableArray *categoriesCurrBudget;
@property (strong, nonatomic) AddTransactionController *controller;
@property BOOL budgetSelected;

@end

@implementation AddTransactionPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.budgetSelected = NO;
    _budgets = [[NSMutableArray alloc]init];
    _categoriesCurrBudget = [[NSMutableArray alloc]init];
    
    
    
    
    Budget * bg = [[Budget alloc] init];
    bg.name = @"mybudget";
    bg.categories = [[NSMutableArray alloc] init];
    Category * cate1 = [[Category alloc] init];
    cate1.name = @"hahah";
    [bg.categories addObject:cate1];
    [_budgets addObject:bg];
    
    _controller = UIClientConnector.myClient.addTransaction;
    UIClientConnector.myClient.addTransaction.delegate = self;

    //call function
    [_controller requestBudgetAndCate];
    
    self.budgetPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.budgetPicker.delegate = self;
    self.budgetPicker.dataSource = self;
    self.budgetPicker.showsSelectionIndicator = YES;
    _budgetTF.inputView = self.budgetPicker;
    
    self.categoryPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, 100, 150)];
    self.categoryPicker.delegate = self;
    self.categoryPicker.dataSource = self;
    self.categoryPicker.showsSelectionIndicator = YES;
    _categoryTF.inputView = self.categoryPicker;
    
 
//    [yourpicker setDelegate: self];
//    yourpicker.showsSelectionIndicator = YES;
//    self.budgetTF.inputView = yourpicker;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDataSource
// #3
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.budgetPicker|| pickerView == self.categoryPicker) {
        return 1;
    }

    
    return 0;
}

// #4
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.budgetPicker) {
        if (_budgetTF.text.length < 1) {
            _budgetSelected = NO;
        }
        return [self.budgets count];
    }
    if (pickerView == self.categoryPicker) {
#warning  tobe changed
        if (self.budgetSelected){
            return [self.categoriesCurrBudget count];
        }
        return 0;
    }
    
    return 0;
}

#pragma mark - UIPickerViewDelegate

// #5
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.budgetPicker) {
        self.categoriesCurrBudget = [(Budget *)[self.budgets objectAtIndex:row] categories];
        _budgetSelected = YES;
        return [(Budget *)self.budgets[row] name];
    }
    if (pickerView == self.categoryPicker) {
        if (_budgetSelected){
            return [(Category *)self.categoriesCurrBudget[row] name];
        }
        return nil;
    }
    
    return nil;
}

// #6
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == self.budgetPicker) {
        self.budgetTF.text = [(Budget *)self.budgets[row] name];
        [_budgetTF endEditing:YES];
    }
    if (pickerView == self.categoryPicker) {
        self.categoryTF.text = [(Category *)self.categoriesCurrBudget[row] name];
        [_categoryTF endEditing:YES];
    }
}


#pragma mark - Table view data source
- (IBAction)submitTransaction:(id)sender {
    if (_amountTF.text.length < 1) {
        [self getAlerted:@"Required Fields" msg:@"Please fill in all required fields"];
    }
    else if (![self numberFormatChecker:_amountTF.text]){
         [self getAlerted:@"Number format Error" msg:@"Please enter numbers for budget amount"];
    
    }
    else {
        //get elements
        NSCalendar *calendar            = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *components = [calendar components:(NSCalendarUnitYear|
                                                             NSCalendarUnitMonth |
                                                             NSCalendarUnitDay   |
                                                             NSCalendarUnitHour  |
                                                             NSCalendarUnitMinute|
                                                             NSCalendarUnitSecond) fromDate:[_date date]];
        
        //check whether exceeds amount
        NSNumber *newAmount = [NSNumber numberWithFloat:_amountTF.text.floatValue];
        [self exceedsBudget:newAmount withBudget:_budgetTF.text withCategory:_categoryTF.text];
        [_controller addTransaction:newAmount describe:_descripTF.text category:_categoryTF.text budget:_budgetTF.text date:components];
        
    }

}

- (BOOL) exceedsBudget:(NSNumber *) newAmount withBudget:(NSString*) budget withCategory:(NSString*) cate{
    
    for (Budget* b in _budgets) {
        if ([b.name isEqualToString: budget]) {
            int threshold = b.threshold;
            for (Category *c in b.categories) {
                if ([c.name isEqualToString:cate]){
                    float n = c.spent + [newAmount floatValue];
                    if (n > c.limit*threshold/100) {
                        NSString *notiTitle = [[NSString alloc] initWithFormat:@"Spent over budget with threshold %@ %% ", @(b.threshold).stringValue];
                        NSString *notiContent = [[NSString alloc] initWithFormat:@"You spend over budget %@ in category %@", b.name, c.name];
                        [AppDelegate setNotificationTitleAndContent:notiTitle withContent:notiContent];
                        [AppDelegate registerNotification:1];
                        for (int i = 1; i <  b.remain; ++ i) {
                            [AppDelegate setNotificationTitleAndContent:notiTitle withContent:notiContent];
                            [AppDelegate registerNotification:60*60*24*i];

                        }
#warning lack time interval
                        break;
                    }
                }
            }
        }
    }
    
    return false;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [super tableView:tableView numberOfRowsInSection:section];

}

//alert window
- (void) getAlerted: (NSString*) errorTitle msg:(NSString*) errorMessage {
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:errorTitle
                                          message:errorMessage
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action){
                                   //set all label to red
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

//return NO if not numeric
- (BOOL) numberFormatChecker: (NSString *) mString{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    BOOL isDecimal = [nf numberFromString:mString] != nil;
    
    return isDecimal;
}

//call back functions
- (void) receiveBudgetInfo:(NSMutableArray *)budgetsFromServer{
    _budgets = budgetsFromServer;
    
}

- (void) addSuccessful{
      [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) addFailed{
    [self getAlerted:@"Duplicate transactions" msg:@"You have entered a transaction that's duplicate"];
}


//dismiss keyboards
- (IBAction)dissmissKey:(id)sender {
    [sender resignFirstResponder];
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
