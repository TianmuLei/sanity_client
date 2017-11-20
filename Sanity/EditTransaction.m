//
//  EditTransaction.m
//  Sanity
//
//  Created by Ruyin Shao on 11/18/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "EditTransaction.h"
#import "Budget.h"
#import "Category.h"
#import "UIClientConnector.h"
#import "EditTransController.h"
#import "AppDelegate.h"

@interface EditTransaction ()<UIPickerViewDelegate, UIPickerViewDataSource>
//UI Elements
@property (weak, nonatomic) IBOutlet UITextField *budgetTF;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UITextField *categoryTF;
@property (weak, nonatomic) IBOutlet UITextField *descripTF;
@property UIPickerView *budgetPicker;
@property UIPickerView *categoryPicker;

//Arrays
@property (strong, nonatomic) NSMutableArray *budgets;
@property (strong, nonatomic) NSMutableArray *categoriesCurrBudget;
@property (strong, nonatomic) EditTransController *controller;
@property BOOL budgetSelected;



@end

@implementation EditTransaction

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.budgetSelected = NO;
    _budgets = [[NSMutableArray alloc]init];
    _categoriesCurrBudget = [[NSMutableArray alloc]init];
    
#warning need new controller
    
    _controller = UIClientConnector.myClient.editTrans;
    UIClientConnector.myClient.editTrans.delegate = self;
    
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
    
    _budgetTF.text = self.oldbudget;
    _categoryTF.text = self.oldcategory;
    _amountTF.text = self.oldAmount;
    _date.text = self.dateText;
    _descripTF.text = self.olddescrip;
    
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
            //  _budgetSelected = NO;
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
        if (row > -1){
            self.categoriesCurrBudget = [(Budget *)[self.budgets objectAtIndex:row] categories];
            _budgetSelected = YES;
            return [(Budget *)self.budgets[row] name];
        }
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
        self.categoriesCurrBudget = [(Budget *)[self.budgets objectAtIndex:row] categories];
        [_budgetTF endEditing:YES];
    }
    if (pickerView == self.categoryPicker) {
        self.categoryTF.text = [(Category *)self.categoriesCurrBudget[row] name];
        [_categoryTF endEditing:YES];
    }
}


#pragma mark - Table view data source
- (IBAction)submitTransaction:(id)sender {
    if (_amountTF.text.length < 1 || _budgetTF.text.length < 1 || _categoryTF.text.length < 1) {
        [self getAlerted:@"Required Fields" msg:@"Please fill in all required fields"];
    }
    
    else if (![self numberFormatChecker:_amountTF.text]){
        [self getAlerted:@"Number format Error" msg:@"Please enter numbers for transaction amount"];
        
    }
    else {
        //get element
        
        //check whether exceeds amount
        NSNumber *newAmount = [NSNumber numberWithFloat:_amountTF.text.floatValue];
        [self exceedsBudget:newAmount withBudget:_budgetTF.text withCategory:_categoryTF.text];
#warning call controller edit
       
        
    }
    
    
    
}
- (IBAction)deleteTrans:(id)sender {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *amountNum = [f numberFromString:_amountTF.text];
    [_controller deleteTransaction:amountNum describe:_olddescrip category:_oldcategory budget:_oldbudget date:_dateText];
}

- (BOOL) exceedsBudget:(NSNumber *) newAmount withBudget:(NSString*) budget withCategory:(NSString*) cate{
    
    for (Budget* b in _budgets) {
        if ([b.name isEqualToString: budget]) {
            int threshold = b.threshold;
            
            for (Category *c in b.categories) {
                if ([c.name isEqualToString:cate]){
                    float n = c.spent + [newAmount floatValue];
                    float remainingAmount = b.total - b.spent - [newAmount floatValue];
                    if (n > c.limit*threshold/100) {
                        NSString *notiTitle = [[NSString alloc] initWithFormat:@"Spent over budget with threshold %@ %% ", @(b.threshold).stringValue];
                        NSString *notiContent = [[NSString alloc] initWithFormat:@"You spend over budget %@ in category %@, date remaining %@, amount remainging %@", b.name, c.name,@(b.remain).stringValue,@(remainingAmount).stringValue];
                        [AppDelegate setNotificationTitleAndContent:notiTitle withContent:notiContent];
                        [AppDelegate registerNotification:3];
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

- (float) remainingAmountCalc:(Budget*) b newAmount: (float) amount{
    
    return 0.0f;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
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
- (IBAction)deleteTransaction:(id)sender {
    
    
}

//call back functions
- (void) receiveBudgetInfo:(NSMutableArray *)budgetsFromServer{
    _budgets = budgetsFromServer;
    
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
