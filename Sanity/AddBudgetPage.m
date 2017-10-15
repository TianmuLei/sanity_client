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

typedef enum:NSInteger{
    sectionName = 0,
    sectionCategory = 1,
    sectionSubmit = 2,
    
}SectionType;

@interface AddBudgetPage ()



@property (weak, nonatomic) IBOutlet UITextField *budgetNameTF;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (weak, nonatomic) IBOutlet UITextField *periodTF;

@property (nonatomic, strong) NSMutableArray *hobbysArr;
@property (nonatomic, strong) NSMutableArray *categoryNameCells;
@property (nonatomic, strong) NSMutableArray *categoryAmountCells;

@end

@implementation AddBudgetPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSetUp];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void) initSetUp {
    _categoryNameCells = [[NSMutableArray alloc] init];
    _categoryAmountCells = [[NSMutableArray alloc] init];

}

- (void) addBudgetSucceeded:(Budget *)budget {
    
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
    mBudget.name = budgetName;
    mBudget.period = [_periodTF.text intValue];
    mBudget.startDate = [_datePicker date];
  
    for (int i = 1; i < _categoryNameCells.count; ++i) {
        HobbyCell *nameCell = _categoryNameCells[i];
        AmountCell *amountCell = _categoryAmountCells[i];
        Category *cate1 = [[Category alloc] init];
        
        //assign attributes to category
        cate1.name = nameCell.categoryNameTF.text;
        cate1.limit = [amountCell.amountTF.text intValue];
        

        //add one category inside
        [mBudget.categories addObject:cate1];
        mBudget.total += cate1.limit;
    }

    
}


- (void)addData{
    
    [self.hobbysArr addObject:@1];
    [self.hobbysArr addObject:@1];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionCategory] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)deleteData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.hobbysArr removeObjectAtIndex:0];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionCategory] withRowAnimation:UITableViewRowAnimationNone];
        self.hobbysArr.count>5?[self deleteData]:[self addData];
    });
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(sectionCategory == section){
        return self.hobbysArr.count;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(sectionCategory == indexPath.section){
        if (indexPath.row % 2 == 0){
            HobbyCell *cell = [tableView dequeueReusableCellWithIdentifier:HobbyCellID];
            if(cell == nil){
                cell = [[NSBundle mainBundle] loadNibNamed:HobbyCellID owner:nil options:nil].lastObject;
            }
            [_categoryNameCells addObject:cell];
            return cell;
        }
        else {
            AmountCell *cell = [tableView dequeueReusableCellWithIdentifier:AmountCellID];
            if(cell == nil){
                cell = [[NSBundle mainBundle] loadNibNamed:AmountCellID owner:nil options:nil].lastObject;
            }
            [_categoryAmountCells addObject:cell];
            return cell;
        }
    }
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
        return [super tableView:tableView indentationLevelForRowAtIndexPath: [NSIndexPath indexPathForRow:0 inSection:sectionCategory]];
    }
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}


- (NSMutableArray *)hobbysArr{
    if(!_hobbysArr){
        _hobbysArr = [NSMutableArray array];
    }
    return _hobbysArr;
}

@end
