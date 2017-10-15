//
//  HomePageTableViewController.m
//  CS310
//
//  Created by Gu on 10/6/17.
//  Copyright © 2017 Gu. All rights reserved.
//

#import "HomePageTableViewController.h"
#import "ViewControllerTest.h"

@interface HomePageTableViewController ()

@end

@implementation HomePageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getLatest)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];
    
    // End the refreshing
    if(self.refreshControl)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}


- (void) getLatest
{
    //update data
    #warning hard-coded, to be changed
    self.tableContent = @[@"iPhone1", @"iPhone2",@"iPhone3",@"iPhone4",@"iPhone5",@"iPad"];
    #warning hard-coded content, to be changed
    self.colors = @[@"black",@"black",@"black",@"orange",@"red",@"orange"];
    
    [self reloadData];
}

/*
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.tableContent.count;
}


//Configure the cells in table
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BudgetListCell" forIndexPath:indexPath];
    
    //set text
    cell.textLabel.text  = self.tableContent[indexPath.row];
    //set font
    cell.textLabel.font = [UIFont fontWithName:@"Arial" size: 25.0];
    //set color
    if([self.colors[indexPath.row] isEqualToString:@"black"])
    {
        cell.textLabel.textColor = [UIColor blackColor];
    }else if([self.colors[indexPath.row] isEqualToString:@"orange"])
    {
        cell.textLabel.textColor = [UIColor orangeColor];
    }else if([self.colors[indexPath.row] isEqualToString:@"red"])
    {
        cell.textLabel.textColor = [UIColor redColor];
    }
    return cell;
}


//redirect to next page
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    [self performSegueWithIdentifier:@"HomeToBudget" sender:tableView];
}

//send parameter to next page by directing changing the values
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"HomeToBudget"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ViewControllerTest * destViewController = segue.destinationViewController;
        //destViewController.indexNum = indexPath.row;
        int indexSelected = (int) indexPath.row;
        destViewController.nameSelected = self.tableContent[indexSelected];
        destViewController.slices = [[NSMutableArray alloc] init];
        destViewController.texts = [[NSMutableArray alloc] init];
        for(int i = 0; i < 5; i ++)
        {
            NSNumber * temp = [NSNumber numberWithInt:rand()%60+20];
            int tempInt = [temp integerValue];
            [destViewController.slices addObject:temp];
            [destViewController.texts addObject:[[NSString alloc] initWithFormat:@"Food%d",i]];
        }
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
