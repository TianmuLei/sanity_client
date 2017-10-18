//
//  AddBudgetPage.m
//  Sanity
//
//  Created by Ruyin Shao on 10/13/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "AddBudgetPage.h"
#import "AmountCell.h"
#import "HobbyCell.h"
#import "Budget.h"
#import "Category.h"
#import "AddBudgetController.h"
#import "UIClientConnector.h"

typedef enum:NSInteger{
    sectionName = 0,
    sectionCategory = 1,
    sectionSubmit = 2,
    
}SectionType;

@interface AddBudgetPage ()

//UI Elements
@property (weak, nonatomic) IBOutlet UITextField *budgetNameTF;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITextField *thresholdTF;

@property (weak, nonatomic) IBOutlet UITextField *periodTF;
@property (weak, nonatomic) IBOutlet UITextField *frequencyTF;

//class instances
@property (nonatomic, strong) NSMutableArray *categories;
@property (nonatomic, strong) NSMutableArray *categoryNameCells;
@property (nonatomic, strong) NSMutableArray *categoryAmountCells;
@property (nonatomic, strong) AddBudgetController *controller;
@property int threshold;
@property NSNumber *frequency;

@end

@implementation AddBudgetPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetUp];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void) initSetUp {
    _categories = [[NSMutableArray alloc] init];
    _categoryNameCells = [[NSMutableArray alloc] init];
    _categoryAmountCells = [[NSMutableArray alloc] init];
    [self.categories addObject:@1];
    [self.categories addObject:@1];
    
}


//dismiss keyboards

- (IBAction)dissmissBudgetKey:(id)sender {
    [self.budgetNameTF resignFirstResponder];
}
- (IBAction)dissmissPeriodKey:(id)sender {
    [self.periodTF resignFirstResponder];
}
- (IBAction)dismissThresholdKey:(id)sender {
    [self.thresholdTF resignFirstResponder];
}
- (IBAction)dismissFrequencyKey:(id)sender {
    [self.frequencyTF resignFirstResponder];
}



- (void) addBudgetSucceeded {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) addBudgetFailed {
    [self getAlerted:@"Duplicate Name" msg:@"You cannot have two budgets with the same name"];
    
}


//clicked add category button
- (IBAction)addCell:(id)sender {
    [self addData];
}

//clicked submit
- (IBAction)submitNewBudget:(id)sender {
    
    //create a new budget
    Budget *mBudget = [[Budget alloc] init];
    NSString *budgetName = _budgetNameTF.text;
    
    //cast NSdate to NSDatecomponent
    NSCalendar *calendar            = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear|
                                                         NSCalendarUnitMonth |
                                                         NSCalendarUnitDay   |
                                                         NSCalendarUnitHour  |
                                                         NSCalendarUnitMinute|
                                                         NSCalendarUnitSecond) fromDate:[_datePicker date]];
    
    
    if (budgetName.length < 1){
        [self getAlerted:@"Required Fields" msg:@"Please fill in all required fields"];
        _budgetNameTF.layer.borderColor=[[UIColor redColor]CGColor];
        _budgetNameTF.layer.borderWidth= 1.0f;
    }
    else if (_periodTF.text.length < 1) {
        [self getAlerted:@"Required Fields" msg:@"Please fill in all required fields"];
        _periodTF.layer.borderColor = [[UIColor redColor]CGColor];
        _periodTF.layer.borderWidth = 1.0f;
    }
    else if (_thresholdTF.text.length < 1) {
        [self getAlerted:@"Required Fields" msg:@"Please fill in all required fields"];
        _thresholdTF.layer.borderColor = [[UIColor redColor]CGColor];
        _thresholdTF.layer.borderWidth = 1.0f;
    }
    else if (![self numberFormatChecker:_periodTF.text]){
        [self getAlerted:@"Number Format Error" msg:@"Please fill in numbers for period"];
    }
    else if (![self numberFormatChecker:_thresholdTF.text]){
        [self getAlerted:@"Number Format Error" msg:@"Please fill in numbers for threshold"];
    }
    else if (![self numberFormatChecker:_frequencyTF.text]){
        [self getAlerted:@"Number Format Error" msg:@"Please fill in numbers for frequency"];
    }
    else {
        BOOL formatError = false;
        mBudget.name = budgetName;
        mBudget.period = [_periodTF.text intValue];
        mBudget.startDate = components;
        mBudget.categories = [[NSMutableArray alloc] init];
        mBudget.threshold = [_thresholdTF.text intValue];
        
        for (int i = 0; i < _categoryNameCells.count; ++i) {
            HobbyCell *nameCell = _categoryNameCells[i];
            AmountCell *amountCell = _categoryAmountCells[i];
            Category *cate1 = [[Category alloc] init];
            
            if (nameCell.categoryNameTF.text.length < 1) {
                [self getAlerted:@"Required Fields" msg:@"Please fill in all required fields"];
                formatError = true;
            }
            else if (amountCell.amountTF.text.length < 1) {
                [self getAlerted:@"Required Fields" msg:@"Please fill in all required fields"];
                formatError = true;
            }
            else if (![self numberFormatChecker:amountCell.amountTF.text]){
                [self getAlerted:@"Number Format Error" msg:@"Please fill in numbers for categories"];
                formatError = true;
            }
            //assign attributes to category
            cate1.name = nameCell.categoryNameTF.text;
            cate1.limit = [amountCell.amountTF.text floatValue];
            
            
            //add one category inside
            [mBudget.categories addObject:cate1];
            mBudget.total += cate1.limit;
        }
        
        NSNumber *frequency = [NSNumber numberWithInt:[_frequencyTF.text intValue]];
        if (mBudget.threshold > 100) {
            [self getAlerted:@"Threshold Error" msg:@"Threshold cannot exceeds 100"];
            formatError = true;
        }
#warning  get controller / delegete = self
        if (!formatError){
            _controller = UIClientConnector.myClient.addBudget;
            UIClientConnector.myClient.addBudget.delegate = self;
            [_controller addBudget:mBudget.name period:[NSNumber numberWithInt:mBudget.period] date:mBudget.startDate category:mBudget.categories threshold:[NSNumber numberWithFloat:mBudget.threshold] frequency:frequency];
        }
    }
    //  [self addBudgetFailed];
}


- (void)addData{
    [_categoryNameCells removeAllObjects];
    [_categoryAmountCells removeAllObjects];
    
    [self.categories addObject:@1];
    [self.categories addObject:@1];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionCategory] withRowAnimation:UITableViewRowAnimationNone];
}

#warning NOT Complete don't use this
- (void)deleteData{
    [self.categories removeObjectAtIndex:0];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionCategory] withRowAnimation:UITableViewRowAnimationNone];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(sectionCategory == section){
        return self.categories.count;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == sectionCategory){
        //int x = indexPath.row;
        //  int y = _categories.count;
        // if (indexPath.row >= _categories.count - 2){
        if (indexPath.row % 2 == 0){
            HobbyCell *cell = [tableView dequeueReusableCellWithIdentifier:HobbyCellID];
            if(cell == nil){
                cell = [[NSBundle mainBundle] loadNibNamed:HobbyCellID owner:nil options:nil].lastObject;
                cell.categoryNameTF.text = @"";
            }
            cell.categoryNameTF.text = @"";
            [_categoryNameCells addObject:cell];
            return cell;
        }
        else {
            AmountCell *cell = [tableView dequeueReusableCellWithIdentifier:AmountCellID];
            if(cell == nil){
                cell = [[NSBundle mainBundle] loadNibNamed:AmountCellID owner:nil options:nil].lastObject;
                cell.amountTF.text = @"";
            }
            cell.amountTF.text = @"";
            [_categoryAmountCells addObject:cell];
            return cell;
        }
    }
    //  }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(sectionCategory == indexPath.section){
        return HobbyCellHeight;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(sectionCategory == indexPath.section){
        int insertLoc = 0;
        return [super tableView:tableView indentationLevelForRowAtIndexPath: [NSIndexPath indexPathForRow:insertLoc inSection:sectionCategory]];
    }
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
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


- (NSMutableArray *)categories{
    if(!_categories){
        _categories = [NSMutableArray array];
    }
    return _categories;
}

//return NO if not numeric
- (BOOL) numberFormatChecker: (NSString *) mString{
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    BOOL isDecimal = [nf numberFromString:mString] != nil;
    
    return isDecimal;
}

@end
