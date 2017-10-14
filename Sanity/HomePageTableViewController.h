//
//  HomePageTableViewController.h
//  CS310
//
//  Created by Gu on 10/6/17.
//  Copyright © 2017 Gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong,nonatomic) NSArray * tableContent;
@property (strong,nonatomic) NSArray * colors;

@end
