//
//  EditBudgetPage.m
//  Sanity
//
//  Created by Ruyin Shao on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "EditBudgetPage.h"
#import "CategoryDisplay.h"

@interface EditBudgetPage ()
@property (weak, nonatomic) IBOutlet UILabel *budgetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *periodTF;
@property (weak, nonatomic) IBOutlet UITextField *thresholdTF;


//data set
@property (strong, nonatomic) NSMutableArray *categories;

@end

@implementation EditBudgetPage

- (void)viewDidLoad {
    [super viewDidLoad];
    _categories = [[NSMutableArray alloc] init];


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
        return _categories.count;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (IBAction)addCell:(id)sender {
    [ _categories addObject:@"whatttt" ];
    [ _categories addObject:@"whatttt" ];
    [ _categories addObject:@"whatttt" ];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1){
        for (int i = 0; i < _categories.count; i++) {
            CategoryDisplay *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryDisplayCell"];
            if(cell == nil){
                cell = [[NSBundle mainBundle] loadNibNamed:@"CategoryDisplayCell" owner:nil options:nil].lastObject;
            }
            
            return cell;
        }
    }
    
    
    return  [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        int insertLoc = 0;
        // if (_categories.count > 2) insertLoc = (int)_categories.count - 3;
        return [super tableView:tableView indentationLevelForRowAtIndexPath: [NSIndexPath indexPathForRow:insertLoc inSection:1]];
    }
    return [super tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
}

- (NSMutableArray *)categories{
    if(!_categories){
        _categories = [NSMutableArray array];
    }
    return _categories;
}

@end
