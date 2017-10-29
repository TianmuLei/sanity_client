//
//  AddCategoryPage.h
//  Sanity
//
//  Created by Ruyin Shao on 10/16/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "ViewController.h"
#import "AddCategoryController.h"
#import "UIClientConnector.h"

@interface AddCategoryPage : ViewController<AddCategoryControllerDelegate>

@property NSString* budgetName;

- (void) addSuccessful;
- (void) addFailed: (NSString *)reasonTitle withReason:(NSString *)reason;

@end
