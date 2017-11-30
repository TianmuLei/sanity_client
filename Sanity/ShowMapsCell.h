//
//  ShowMapsCell.h
//  Sanity
//
//  Created by Gu on 11/27/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleCategoryTableViewController.h"

@interface ShowMapsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *showMapButton;
@property (retain, nonatomic) SingleCategoryTableViewController* delegate;

@end
