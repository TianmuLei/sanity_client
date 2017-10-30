//
//  EditBudgetPage.m
//  Sanity
//
//  Created by Ruyin Shao on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "EditBudgetPage.h"
#import "CategoryDisplay.h"
#import "Category.h"
#import "EditBudgetController.h"
#import "AddCategoryPage.h"

@interface EditBudgetPage ()
@property (weak, nonatomic) IBOutlet UITextField *budgetNameTF;

@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *periodTF;
@property (weak, nonatomic) IBOutlet UITextField *thresholdTF;
@property (weak, nonatomic) IBOutlet UITextField *frequencyTF;

@property EditBudgetController *controller;
@property NSIndexPath *toBeDeleteRow;
@property BOOL canDeleteCategories;


//data set
@property (strong, nonatomic) NSMutableArray *categories;
@property (strong, nonatomic) NSMutableArray *cateCells;
@end

@implementation EditBudgetPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categories = [[NSMutableArray alloc] init];
    self.cateCells = [[NSMutableArray alloc] init];
    Category *testCate = [[Category alloc]init];
    testCate.name = @"test1";
    testCate.limit = 10.25f;
    [ _categories addObject:testCate];
    _canDeleteCategories = NO;
    
    
    _controller = UIClientConnector.myClient.editBudget;
    UIClientConnector.myClient.editBudget.delegate = self;

    Budget *b = [UIClientConnector.myClient getBudget:_budgetName];

    [self getBudgetInfo:b];
}


//reload section two
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //select section 2 and reload data
    NSRange range = NSMakeRange(1, 1);
    NSIndexSet *section = [NSIndexSet indexSetWithIndexesInRange:range];
    
    _controller = UIClientConnector.myClient.editBudget;
    UIClientConnector.myClient.editBudget.delegate = self;

    Budget *b = [UIClientConnector.myClient getBudget:_budgetName];
    // [_controller requestBudget:_budgetName];
    [self getBudgetInfo:b];
    
    [self.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissKeyboard:(id)sender {
    [sender resignFirstResponder];
}





-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"EditBudgetToAddCate"]){
        AddCategoryPage *addCatePage = (AddCategoryPage *)segue.destinationViewController;
        addCatePage.budgetName = self.budgetName;
    }
}

- (IBAction)deleteBudget:(id)sender {
    [_controller deleteBudget:_budgetName];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.categories.count;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}


- (IBAction)deleteCell:(id)sender {
    _canDeleteCategories = YES;
    //[self.tableView setEditing:YES animated:YES];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}
//submission get data
- (IBAction)submitEdit:(id)sender {
    NSString *budgetName = _budgetNameTF.text;
    [_controller editBudget:_budgetName withnewBudget:_budgetNameTF.text withPeriod:_periodTF.text withThreshold:_thresholdTF.text withFrequency:_frequencyTF.text];
    
    for (int i = 0; i < _categories.count; ++i){
        //budget name could be changed, so get it from text field
        Category *cate = [_categories objectAtIndex:i];
        CategoryDisplay *cateDisplay = [_cateCells objectAtIndex:i+2];
        NSString *testCell = cateDisplay.categoryNameTF.text;
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        [_controller editCategory:_budgetNameTF.text :cate.name :cateDisplay.categoryNameTF.text :[f numberFromString: cateDisplay.categoryAmountTF.text ]];
    }
}


//allow edit mode for list
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        return YES;
    }
    return NO;
}

//delete cell
- (void)tableView:(UITableView *)tableview commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        //alert Do you really want to remove this category?
        CategoryDisplay *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString *alertMsg = [NSString stringWithFormat:@"Are you sure you want to delete %@?", cell.categoryNameTF.text];
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Delete Category"
                                              message:alertMsg preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action){
                                           //do nothing
                                       }];
        
        UIAlertAction *okAction = [UIAlertAction
                                   actionWithTitle:@"Yes"
                                   style:UIAlertActionStyleDestructive
                                   handler:^(UIAlertAction *action){
#warning call@jiaxin's function confirm delete
                                       //Delete the object from the friends array and the table.
                                       [_controller deleteCategory:_budgetName :cell.categoryNameTF.text ];
                                       
                                       //delete category from two arraylists
//                                       for (Category *cate in _categories){
//                                           if ([cate.name isEqual:cell.categoryNameTF.text]){
//                                               [_categories removeObject:cate];
//                                           }
//                                       }
//                                       
//                                       for (CategoryDisplay * cellA in _cateCells){
//                                           if ([cellA.categoryNameTF.text isEqual:cell.categoryNameTF.text]){
//                                               [_cateCells removeObject:cellA];
//                                           }
//                                       }
//                                       
                                       _toBeDeleteRow = indexPath;
                                   
                                   }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1){
        if (_canDeleteCategories) {
            [self.tableView setEditing:YES animated:YES];
        }
        CategoryDisplay *cell = [tableView dequeueReusableCellWithIdentifier:CategoryDisplayID];
        Category *tempCate = [_categories objectAtIndex:indexPath.row];
        
        
        if(cell == nil){
            cell = [[NSBundle mainBundle] loadNibNamed:CategoryDisplayID owner:nil options:nil].lastObject;
            //set name and amount
            cell.categoryAmountTF.text =[[NSNumber numberWithFloat:tempCate.limit] stringValue];
            cell.categoryNameTF.text = tempCate.name;
            NSString *todelte = cell.categoryNameTF.text;
            [_cateCells addObject:cell];
            
        }
        
        
        return cell;
    }
    return  [super tableView:tableView cellForRowAtIndexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        return CategoryDisplayHeight;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        return [super tableView:tableView indentationLevelForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:1]];
    }
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}
//set budget before load page
- (void) getBudgetInfo:(Budget *)budget{
    self.budgetNameTF.text = budget.name;
    self.startDateLabel.text = budget.startDateString;
    
    /*[NSDateFormatter localizedStringFromDate:[budget.startDate date]
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterFullStyle];*/
    self.periodTF.text = [[NSNumber numberWithInt:budget.period] stringValue];
    self.thresholdTF.text = [[NSNumber numberWithInt:budget.threshold] stringValue];
    self.frequencyTF.text = [[NSNumber numberWithInt:budget.frequency] stringValue];
    self.categories = [[NSMutableArray alloc] init];
    self.categories = budget.categories;//get categories
    
    
}

// call back functions
- (void) deleteCategorySuccess {
    [_categories removeObjectAtIndex:_toBeDeleteRow.row];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:_toBeDeleteRow] withRowAnimation:UITableViewRowAnimationFade];
}
- (void) deleteCategoryFail {
    [self getAlerted:@"Delete Failed" msg:@"Server receives error message."];
}
- (void) editEntireBudgetSuccess {
#warning Need to refreshpage
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void) editEntireBudgetFail {
    [self getAlerted:@"Update failed" msg:@"Update error occured"];
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

@end
