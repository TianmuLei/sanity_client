//
//  CategoryDisplay.h
//  Sanity
//
//  Created by Ruyin Shao on 10/15/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import <UIKit/UIKit.h>

/** ID */
#define CategoryDisplayID @"CategoryDisplay"
/** height */
#define CategoryDisplayHeight 50

@interface CategoryDisplay : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *categoryNameTF;
@property (weak, nonatomic) IBOutlet UITextField *categoryAmountTF;

@end
