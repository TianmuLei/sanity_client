//
//  AddBudgetController.h
//  Sanity
//
//  Created by Tianmu on 10/14/17.
//  Copyright © 2017 Absolute A. All rights reserved.
//

#import "MainController.h"
#import "Category.h"

@protocol  AddBudgetControllerDelegate<NSObject>
//add call back function here
- (void) addBudgetSucceeded;
- (void) addBudgetFailed;
@required
@end

@interface AddBudgetController : MainController{
    id <AddBudgetControllerDelegate> _delegate;
}
@property (nonatomic,strong) id delegate;
-(void) addBudget: (NSString*) name period:(NSNumber*) period date:(NSDateComponents*) startDate category:(NSMutableArray*)category threshold:(NSNumber*) threshold frequency:(NSNumber*) frequency;
-(void) success;
-(void) fail;
@end
