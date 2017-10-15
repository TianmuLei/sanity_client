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

typedef enum:NSInteger{
    sectionName = 0,
    sectionCategory = 1,
    sectionSubmit = 2,
    
}SectionType;

@interface AddBudgetPage ()

@property (nonatomic, strong) NSMutableArray *hobbysArr;

@end

@implementation AddBudgetPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /** 延时添加数据 */
    
    
}

- (IBAction)addCell:(id)sender {
    [self addData];
}

- (void)addData{
    
    [self.hobbysArr addObject:@1];
    [self.hobbysArr addObject:@1];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionCategory] withRowAnimation:UITableViewRowAnimationNone];
    //
    //        self.hobbysArr.count>5?[self deleteData]:[self addData];
    //
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
    if(sectionCategory == section){//爱好 （动态cell）
        return self.hobbysArr.count;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(sectionCategory == indexPath.section){//爱好 （动态cell）
        if (indexPath.row % 2 == 0){
            HobbyCell *cell = [tableView dequeueReusableCellWithIdentifier:HobbyCellID];
            if(cell == nil){
                cell = [[NSBundle mainBundle] loadNibNamed:HobbyCellID owner:nil options:nil].lastObject;
            }
            return cell;
        }
        else {
            AmountCell *cell = [tableView dequeueReusableCellWithIdentifier:AmountCellID];
            if(cell == nil){
                cell = [[NSBundle mainBundle] loadNibNamed:AmountCellID owner:nil options:nil].lastObject;
            }
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
