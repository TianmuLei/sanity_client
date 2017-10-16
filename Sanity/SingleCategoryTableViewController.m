//
//  SingleCategoryTableViewController.m
//  Sanity
//
//  Created by Gu on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "SingleCategoryTableViewController.h"
#import "PieChartCell.h"
#import "TranscationLabelCell.h"
#import "TransactionCell.h"

@interface SingleCategoryTableViewController ()
@end

@implementation SingleCategoryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



//for displaying pie chart
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numOfTransactions+2;
}

//Configure the cells in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //set up pie chart
    if(indexPath.row == 0){
        PieChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleCategoryPieChartCell" forIndexPath:indexPath];
        cell.detailLabel.text = self.textForPieChart;
        //set label color
        if([self.pieChartLabelColor isEqualToString:@"black"])
        {
            cell.detailLabel.textColor = [UIColor blackColor];
        }else if([self.pieChartLabelColor isEqualToString:@"orange"])
        {
            cell.detailLabel.textColor = [UIColor orangeColor];
        }else if([self.pieChartLabelColor isEqualToString:@"red"])
        {
            cell.detailLabel.textColor = [UIColor redColor];
        }
        cell.texts = self.texts;
        cell.slices = self.slices;
        return cell;
    }else if(indexPath.row == 1){ //set up "Transaction" labell
        TranscationLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleCategoryTransactionLabelCell" forIndexPath:indexPath];
        return cell;
    }else {//set up transactions
        TransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleCategoryTransactionCell" forIndexPath:indexPath];
        cell.nameLabel.text = self.transactionNames[indexPath.row-2];
        cell.amountLabel.text = self.transactionAmounts[indexPath.row-2];
        cell.dateLabel.text = self.transactionDates[indexPath.row-2];
        return cell;
    }
    
}

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
