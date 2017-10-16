//
//  EditBudgetPage.m
//  Sanity
//
//  Created by Ruyin Shao on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "EditBudgetPage.h"
#import "CategoryDisplay.h"
#import "HobbyCell.h"
#import "Category.h"

@interface EditBudgetPage ()
@property (weak, nonatomic) IBOutlet UILabel *budgetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *periodTF;
@property (weak, nonatomic) IBOutlet UITextField *thresholdTF;
@property BOOL canDeleteCategories;


//data set
@property (strong, nonatomic) NSMutableArray *categories;
@end

@implementation EditBudgetPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categories = [[NSMutableArray alloc] init];
    Category *testCate = [[Category alloc]init];
    testCate.name = @"test1";
    testCate.limit = 10.25f;
    [ _categories addObject:testCate];
    // [ _categories addObject:@"whatttt" ];
    // [ _categories addObject:@"whatttt" ];
    _canDeleteCategories = NO;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)addCell:(id)sender {

}
- (IBAction)deleteCell:(id)sender {
    _canDeleteCategories = YES;
    //[self.tableView setEditing:YES animated:YES];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
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
        HobbyCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString *alertMsg = [NSString stringWithFormat:@"Are you sure you want to delete %@?", cell.categoryNameLabel.text];
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
                                       [_categories removeObjectAtIndex:indexPath.row];
                                       [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
        HobbyCell *cell = [tableView dequeueReusableCellWithIdentifier:HobbyCellID];
        Category *tempCate = [_categories objectAtIndex:indexPath.row];
        
        
        if(cell == nil){
            cell = [[NSBundle mainBundle] loadNibNamed:HobbyCellID owner:nil options:nil].lastObject;
            //set name and amount
            cell.categoryNameTF.text =[[NSNumber numberWithFloat:tempCate.limit] stringValue];
            cell.categoryNameLabel.text = tempCate.name;
            
        }
        
        return cell;
    }
    return  [super tableView:tableView cellForRowAtIndexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        return HobbyCellHeight;
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
    self.budgetNameLabel.text = budget.name;
    self.startDateLabel.text = [NSDateFormatter localizedStringFromDate:[budget.startDate date]
                                                              dateStyle:NSDateFormatterShortStyle
                                                              timeStyle:NSDateFormatterFullStyle];
    self.periodTF.text = [[NSNumber numberWithInt:budget.period] stringValue];
    self.thresholdTF.text = [[NSNumber numberWithInt:budget.threshold] stringValue];
    self.categories = [[NSMutableArray alloc] init];
    self.categories = budget.categories;//get categories
    
}

@end
